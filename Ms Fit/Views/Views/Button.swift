//
//  Button.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

protocol Highlightable: class {
    var highlighted: Bool { get set }
}

protocol Selectable: class {
    var selected: Bool { get set }
}

extension UILabel: Highlightable, Selectable {
    var highlighted: Bool {
        get { return isHighlighted }
        set { isHighlighted = newValue }
    }
    
    var selected: Bool {
        get { return isHighlighted }
        set { isHighlighted = newValue }
    }
}

class Button: UIButton {
    
    convenience init(icon: String, font: UIFont = UIFont.systemFont(ofSize: 17.0),
                     size: CGFloat = UIFont.systemFontSize,
                     textColor: UIColor = UIColor.black) {
        self.init()
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        setTitle(icon, for: .normal)
        setTitleColor(textColor, for: .normal)
    }
    
    static let minTouchSize: CGFloat = 44.0
    
    private var animated: Bool = false
    private var spinner: UIActivityIndicatorView?
    private var localizeID: String? = ""
    private var fontSize: CGFloat = 16.0
    private var _isUpperCased = false
    fileprivate let disposeBag = DisposeBag()
    
    @IBOutlet var highlightings: [UIView] = []
    @IBOutlet var selectings: [UIView] = []
    
    @IBInspectable var insets: CGSize = CGSize.zero
    @IBInspectable var spinnerColor: UIColor?
    @IBInspectable lazy var normalColor: UIColor = self.backgroundColor ?? UIColor.clear
    @IBInspectable lazy var highlightedColor: UIColor = self.defaultHighlightedColor()
    @IBInspectable lazy var selectedColor: UIColor = self.backgroundColor ?? UIColor.clear
    @IBInspectable lazy var disabledColor: UIColor = self.backgroundColor ?? UIColor.clear
    
    @IBInspectable var isUpperCased: Bool = false {
        willSet {
            if newValue {
                _isUpperCased = newValue
                setTitle(title(for: .normal)?.uppercased(), for: .normal)
            }
        }
    }
    
    @IBInspectable var rotate: Bool = false {
        willSet {
            if newValue == true {
                switch contentMode {
                case .bottom:
                    transform = CGAffineTransform(rotationAngle: .pi)
                case .left:
                    transform = CGAffineTransform(rotationAngle: -(.pi/2))
                case .right:
                    transform = CGAffineTransform(rotationAngle: .pi/2)
                default:
                    transform = CGAffineTransform.identity
                }
            }
        }
    }
    
    @IBInspectable var touchArea: CGSize = CGSize(width: minTouchSize, height: minTouchSize)
    
    public var loading: Bool = false {
        willSet {
            if loading != newValue {
                if newValue == true {
                    let spinner = UIActivityIndicatorView(style: .large)
                    spinner.color = spinnerColor ?? titleColor(for: UIControl.State())
                    var spinnerSuperView: UIView = self
                    let contentWidth = sizeThatFits(size).width
                    if (self.width - contentWidth) < spinner.width {
                        if let superView = self.superview {
                            spinnerSuperView = superView
                        }
                        spinner.center = center
                        alpha = 0
                    } else {
                        let size = bounds.size
                        spinner.center = CGPoint(x: size.width - size.height/2, y: size.height/2)
                    }
                    spinnerSuperView.addSubview(spinner)
                    spinner.startAnimating()
                    self.spinner = spinner
                    isUserInteractionEnabled = false
                } else {
                    if spinner?.superview != self {
                        alpha = 1
                    }
                    spinner?.removeFromSuperview()
                    isUserInteractionEnabled = true
                }
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            update()
            highlightings.forEach({ ($0 as? Highlightable)?.highlighted = isHighlighted })
        }
    }
    
    override var isSelected: Bool {
        didSet {
            update()
            selectings.forEach({ ($0 as? Selectable)?.selected = isSelected })
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            update()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update()
    }
    
    public func defaultHighlightedColor() -> UIColor {
        return self.backgroundColor ?? UIColor.clear
    }
    
    public func update() {
        let normalColor = self.normalColor
        let selectedColor = self.selectedColor
        let highlightedColor = self.highlightedColor
        let disabledColor = self.disabledColor
        var backgroundColor: UIColor = disabledColor
        if isEnabled {
            if isHighlighted {
                backgroundColor = highlightedColor
            } else {
                backgroundColor = isSelected ? selectedColor : normalColor
            }
        }
        if !(backgroundColor.isEqual(self.backgroundColor)) {
            setBackgroundColor(backgroundColor: backgroundColor, animated: animated)
        }
    }
    
    public func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2.0
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 8, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    override var intrinsicContentSize: CGSize {
        let intrinsicSize = super.intrinsicContentSize
        return CGSize(width: intrinsicSize.width + insets.width, height: intrinsicSize.height + insets.height)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var rect = bounds
        rect = rect.insetBy(dx: -max(0, touchArea.width - rect.width)/2,
                            dy: -max(0, touchArea.height - rect.height)/2)
        return rect.contains(point)
    }
    
    fileprivate var clickHelper: ((Button) -> Void)?
    
    public func click(_ clickHelper: @escaping ((Button) -> Void)) {
        self.addTarget(self, action: #selector(performAction), for: .touchUpInside)
        self.clickHelper = clickHelper
    }
    
    @objc func performAction() {
        clickHelper?(self)
    }
}

final class PressButton: Button {
    
    override func defaultHighlightedColor() -> UIColor {
        return normalColor.withAlphaComponent(0.1)
    }
}

extension UIButton {
    
    public var active: Bool {
        set { setActive(active: newValue, animated: false) }
        get { return alpha > 0.5 && isUserInteractionEnabled }
    }
    
    private func setActive(active: Bool, animated: Bool) {
        setAlpha(alpha: (active ? 1.0 : 0.5), animated: animated)
        isUserInteractionEnabled = active
    }
    
    public func customButton(text: String? = "", font: CGFloat, weight: UIFont.Weight,
                             shadowColor: UIColor? = nil, bgColor: UIColor? = nil) {
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: font, weight: weight)
        tintColor = .systemBackground
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 3)
        backgroundColor = bgColor
        layer.cornerRadius = self.intrinsicContentSize.height
    }
    
    public func animateWhenPressed(disposeBag: DisposeBag) {
        let pressDownTransform = rx.controlEvent([.touchDown, .touchDragEnter])
            .map({ CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95) })
        
        let pressUpTransform = rx.controlEvent([.touchDragExit, .touchCancel,
                                                .touchUpInside, .touchUpOutside])
            .map({ CGAffineTransform.identity })
        
        Observable.merge(pressDownTransform, pressUpTransform)
            .distinctUntilChanged()
            .subscribe(onNext: animate(_:))
            .disposed(by: disposeBag)
    }
    
    private func animate(_ transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        self.transform = transform
        }, completion: nil)
    }
}

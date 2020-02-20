//
//  Label.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

public class Label: UILabel {
    
    private var localizeID: String? = ""
    private var fontSize: CGFloat = 16.0
    private var _isUpperCased = false
    fileprivate let disposeBag = DisposeBag()
    
    convenience init(icon: String,
                     font: UIFont = UIFont.systemFont(ofSize: 17.0),
                     size: CGFloat = UIFont.systemFontSize,
                     textColor: UIColor = UIColor.black) {
        self.init()
        self.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        self.text = icon
        self.textColor = textColor
    }
    
    @IBInspectable var isUpperCased: Bool = false {
        willSet {
            if newValue {
                _isUpperCased = newValue
                text = text?.uppercased()
            }
        }
    }
    
    @IBInspectable var insets: CGSize = CGSize.zero
    
    override open var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + insets.width, height: size.height + insets.height)
    }
    
    @IBInspectable var rotate: Bool = false {
        willSet {
            if newValue == true {
                switch contentMode {
                case .bottom: transform = CGAffineTransform(rotationAngle: .pi)
                case .left: transform = CGAffineTransform(rotationAngle: -(.pi/2))
                case .right: transform = CGAffineTransform(rotationAngle: .pi/2)
                default: transform = CGAffineTransform.identity
                }
            }
        }
    }
}

final class BadgeLabel: Label {
    
    var value = 0 {
        willSet {
            text = String(newValue)
            isHidden = newValue == 0
            cornerRadius = height/2
            textAlignment = .center
            clipsToBounds = true
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size = CGSize(width: size.width + 15, height: size.height + 5)
        layer.cornerRadius = size.height/2
        return size
    }
}

extension UILabel {
    func setLineHeight(_ text: String, lineHeight: CGFloat) {
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineHeight
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                     value: style, range: NSMakeRange(0, text.count))
        self.attributedText = attributeString
    }
}

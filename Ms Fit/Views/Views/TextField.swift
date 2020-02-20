//
//  TextField.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import Foundation

final class TextField: UITextField {
    
    @IBInspectable var disableSeparator: Bool = false
    @IBInspectable var trim: Bool = false
    @IBInspectable var strokeColor: UIColor?
    private weak var highlighLabel: UILabel?
    @IBInspectable var highlightedStrokeColor: UIColor?
    private var localizeID: String? = ""
    private var fontSize: CGFloat = 16.0
    @IBInspectable var localize: Bool = false {
        willSet {
            if let text = placeholder, !text.isEmpty {
                localizeID = text
                fontSize = font?.pointSize ?? 16.0
                super.placeholder = "" + text.ls
            }
        }
    }
    
    @IBInspectable var placeholderTextColor: UIColor? = nil {
        willSet {
            if let text = placeholder, let font = font, let color = newValue , !text.isEmpty {
                attributedPlaceholder = NSMutableAttributedString(string: text, attributes:
                    [NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : font])
            }
        }
    }
    
    override var text: String? {
        didSet {
            sendActions(for: .editingChanged)
        }
    }
    
    override func resignFirstResponder() -> Bool {
        if trim == true, let text = text , !text.isEmpty {
            self.text = text.trim
        }
        
        let flag = super.resignFirstResponder()
        setNeedsDisplay()
        return flag
    }
    
    @discardableResult override func becomeFirstResponder() -> Bool {
        let flag = super.becomeFirstResponder()
        setNeedsDisplay()
        return flag
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard !disableSeparator else { return }
        let path = UIBezierPath()
        var placeholderColor: UIColor?
        if isFirstResponder {
            path.lineWidth = 2
            placeholderColor = highlightedStrokeColor ?? attributedPlaceholder?.foregroundColor
            highlighLabel?.isHighlighted = true
        } else {
            path.lineWidth = 1
            placeholderColor = strokeColor ?? attributedPlaceholder?.foregroundColor
            highlighLabel?.isHighlighted = false
        }
        if let color = placeholderColor {
            let y = bounds.height - path.lineWidth/2.0
            path.move(0 ^ y).line(bounds.width ^ y)
            color.setStroke()
            path.stroke()
        }
    }
}

extension NSAttributedString {
    
    var foregroundColor: UIColor? {
        return attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
    }
}

//
//  UILabel+Ext.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 19.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

extension UILabel {
    func setLineHeight(_ text: String, lineHeight: CGFloat) {
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineHeight
        style.alignment = .center
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                     value: style, range: NSMakeRange(0, text.count))
        self.attributedText = attributeString
    }
}

//
//  OnboardSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    public func customButton(text: String, cornerR: CGFloat, font: CGFloat, weight: UIFont.Weight, shadowColor: UIColor? = nil, bgColor: UIColor) {
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: font, weight: weight)
        setTitleColor(.systemBackground, for: .normal)
        layer.cornerRadius = cornerR
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 3)
        backgroundColor = bgColor
    }
}


//
//  SettingsHeaderView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 02.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class SettingsHeaderView: UIView {
    
    let titleLabel = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 13.0)
    })
    
    public func setup(title: String) {
        add(titleLabel, layoutBlock: { $0.leading(16).bottom(5) })
        titleLabel.text = title
    }
}

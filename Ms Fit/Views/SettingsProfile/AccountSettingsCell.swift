//
//  AccountSettingsCell.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class AccountSettingsCell: UITableViewCell, CellIdentifierable {
    
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    
    private let textField = specify(UITextField(), {
        $0.borderStyle = .none
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    public func setup(with model: AccountModel) {
        textLabel?.text = model.discription().0.localizedCapitalized
        textField.placeholder = model.discription().1
        
        textLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        textLabel?.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        selectionStyle = .none
        backgroundColor = .systemBackground
        
        if model == .editPassword {
            accessoryType = .disclosureIndicator
        } else {
            add(textField, layoutBlock: { $0.trailing(16).centerY() })
        }
        add(separatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
    }
}

//
//  AccountTypeCell.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class AccountTypeCell: UITableViewCell, CellIdentifierable {
    
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    
    private let discriptionLabel = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    })
    
    public func setup(with model: AccountTypeModel) {
        textLabel?.text = model.rawValue
        discriptionLabel.text = model.discription()
        
        textLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        textLabel?.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        selectionStyle = .none
        backgroundColor = .systemBackground

        add(discriptionLabel, layoutBlock: { $0.trailing(16).centerY() })
        add(separatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
    }
}

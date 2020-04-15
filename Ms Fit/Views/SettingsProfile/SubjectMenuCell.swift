//
//  SubjectMenuCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class SubjectMenuCell: UITableViewCell, CellIdentifierable {
    
    public let subjectNameLabel = Label(icon: "", font: .systemFont(ofSize: 15, weight: .regular),
                                        textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: false, textAlignment: .right)
    
    public func setup(_ entry: String) {
        backgroundColor = .clear
        selectionStyle = .none
        subjectNameLabel.text = entry
        add(subjectNameLabel, layoutBlock: { $0.leading(16).top(12).bottom(10).trailing(16) })
    }
    
}

//
//  SubjectMenuCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class SubjectMenuCell: UITableViewCell, CellIdentifierable {
    
    static var identifier: String = "SubjectMenuCell"
    
    public let subjectNameLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    public func setup(_ entry: String) {
        subjectNameLabel.text = entry
        backgroundColor = .clear
        add(subjectNameLabel, layoutBlock: { $0.leading(16).top(12).bottom(10).trailing(16) })
    }
    
}

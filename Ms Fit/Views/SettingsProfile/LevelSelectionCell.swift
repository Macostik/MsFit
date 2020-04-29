//
//  LevelSelectionCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class LevelSelectionCell: UITableViewCell, CellIdentifierable {
    
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    
    public let checkmarkButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "chackmark_icon"), for: .normal)
        $0.tintColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.isUserInteractionEnabled = false
    })
    
    public func setup(with model: ListLevelModel) {
        textLabel?.text = model.rawValue.localizedCapitalized
        textLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        textLabel?.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        selectionStyle = .none
        backgroundColor = .systemBackground
        
        add(separatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
        add(checkmarkButton, layoutBlock: { $0.trailing(16).centerY().size(20) })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkmarkButton.tintColor = selected ? #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1) : .systemBackground
    }
}

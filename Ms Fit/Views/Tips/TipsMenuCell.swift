//
//  TipsMenuCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 17.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class TipsMenuCell: UITableViewCell, CellIdentifierable {
    
    static var identifier: String = "TipsMenuCell"
    
    public let nameLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .systemBackground
    })
    
    private let checkImageView = specify(UIImageView(), {
        $0.image = UIImage(systemName: "checkmark")
        $0.tintColor = .systemBackground
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let separatorView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.4588235294, blue: 0.9333333333, alpha: 1)
    })
    
    func setup(_ item: TipsMenuModel) {
        nameLabel.text = item.rawValue
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        add(separatorView, layoutBlock: { $0.bottom().leading().trailing().height(1) })
        add(nameLabel, layoutBlock: { $0.leading(16).centerY() })
        add(checkImageView, layoutBlock: { $0.trailing(16).width(25).centerY() })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

//
//  HistoryCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 26.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell, CellIdentifierable {
    
    private let containerView = specify(UIView(), {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.3799999952, green: 0.2860000134, blue: 0.7960000038, alpha: 1)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    })
    
    private let changeImageView = specify(UIImageView(), {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "pencil")
    })
    
    private let dateLabel = Label(icon: "Dec 31, 2016", font: .systemFont(ofSize: 16, weight: .regular),
                                  textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    private let resultLabel = Label(icon: "125.0 kg", font: .systemFont(ofSize: 16, weight: .regular),
                                    textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), isTranform: true)
    private let bottomSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1) })
    
    public func setup(_ entry: HistoryModel) {
        dateLabel.text = entry.description().0
        resultLabel.text = entry.description().1
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        let hStackView = HStackView(arrangedSubviews: [resultLabel, containerView], spacing: 10)
        
        add(hStackView, layoutBlock: { $0.leading(16).top(20).bottom(20) })
        add(dateLabel, layoutBlock: { $0.trailing(16).centerY() })
        containerView.add(changeImageView, layoutBlock: {
            $0.size(12).top(4).leading(4).trailing(4).bottom(4)
        })
        add(bottomSeparatorView, layoutBlock: { $0.leading().trailing().bottom().height(1) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

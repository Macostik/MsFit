//
//  TipsCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import SDWebImage

class TipsCell: UICollectionViewCell, CellIdentifierable {
    
    private let tipImageView = specify(UIImageView(), {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    })
    
    private let containerForTextView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = .init(width: 0, height: 2)
        $0.clipsToBounds = false
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    })
    
    private let tipText = Label(icon: "", font: .systemFont(ofSize: 16, weight: .regular), textColor: #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1),
                                isTranform: false, textAlignment: .right)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        handleUI()
        addConstraints()
    }
    
    private func handleUI() {
        backgroundColor = .clear
    }
    
    func addConstraints() {
        containerForTextView.add(tipText, layoutBlock: { $0.leading(10).trailing(10).top(25).bottom(25) })
        add(tipImageView, layoutBlock: { $0.top(15).height(Constants.sW * 0.5).trailing(16).leading(16) })
        add(containerForTextView, layoutBlock: {
            $0.leading(16).bottom().trailing(16).topBottom(to: tipImageView)
        })
    }
    
    public func setup(_ tip: TipsPost) {
        tipImageView.sd_setImage(with: URL(string: tip.picture),
                                 placeholderImage: UIImage(named: "splash_icon"),
                                 options: [.continueInBackground, .highPriority, .retryFailed])
        tipText.text = tip.title
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

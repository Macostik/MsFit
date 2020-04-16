//
//  TipDetailsView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 23.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class TipDetailsView: UICollectionReusableView, CellIdentifierable {
    
    static var identifier: String = "TipDetailsView"
        
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "food2"))
    
    private let titleLabel = specify(UILabel(), {
        $0.text = "الالتزام باشتراك أطول"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    })
    
    private let healthLabel = specify(UILabel(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.text = "الصحة"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 10, weight: .regular)
        $0.textColor = .systemBackground
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    })
    
    private let discriptionLabel = specify(UILabel(), {
        $0.text = """
        Let’s face it: The rules of weight loss—eat less, move more, treats in moderation— are a drag 😕.
        
        And they don’t fit with most dieters’ quick-fix, thinner-by-dinner expectations. Cue diet crutches:
        tricks, based on scant science, that may speed up results 👍🏽.
        
        -
        
        🥮 So if a friend swears that munching on grapefruit gets her into skinny jeans, or a coworker credits
        ice water for his sleek physique, should you try it too? 🥤 Let’s face it: The rules of weight
        loss—eat less, move more, treats in moderation— are a drag. 👍🏽 And they don’t fit with most dieters’
        quick-fix, thinner-by-dinner expectations. Cue diet crutches: tricks, based on scant science,
        that may speed up results. So if a friend swears that munching on grapefruit gets her into skinny
        jeans, or a coworker credits ice water for his sleek physique, should you try it too? 😕
        
        -
        
        ⭐️ Let’s face it: The rules of weight loss—eat less, move more, treats in moderation— are a drag.
        
        ❌🙅‍♀️ And they don’t fit with most dieters’ quick-fix, thinner-by-dinner expectations.
        Cue diet crutches: tricks, based on scant science, that may speed up results. 🥤 So if a friend
        swears that munching on grapefruit gets her into skinny jeans, or a coworker credits ice water for
        his sleek physique, should you try it too? 🍀
        
        -
        
        Let’s face it: 💧 The rules of weight loss—eat less, move more, treats in moderation— are a drag.
        And they don’t fit with most dieters’ quick-fix, thinner-by-dinner expectations.
        Cue diet crutches: tricks, based on scant science, that may speed up results. 🍋
        👏 Let’s face it: The rules of weight loss—eat less, move more, treats in moderation— are a drag.
        And they don’t fit with most dieters’ quick-fix, thinner-by-dinner expectations. 💪😍
        """
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    })
    
    private let separatorView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
    })
    
    private let bottomShadowView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.shadowColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    })
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    func setupUI() {
        backgroundColor = .systemBackground
    }
    
    func setupBindings() {
        
    }
    
    func addConstraints() {
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        healthLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        healthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let titleVStackView = VStackView(arrangedSubviews: [
            imageView, titleLabel,
            HStackView(arrangedSubviews: [healthLabel, UIView()]),
            separatorView, discriptionLabel
            ], spacing: 16)
        
        add(imageView, layoutBlock: { $0.top().leading().trailing().height(Constants.sW * 0.9) })
        add(titleVStackView, layoutBlock: {
            $0.topBottom(16, to: imageView).leading(16).trailing(16).bottom(50)
        })
        add(bottomShadowView, layoutBlock: { $0.bottom().leading().trailing().height(30) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

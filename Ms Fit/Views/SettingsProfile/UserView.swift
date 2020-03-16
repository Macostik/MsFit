//
//  UserView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class UserView: UIView {
    
    public let settingsButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "settings_icon"), for: .normal)
        $0.tintColor = #colorLiteral(red: 0.5333333333, green: 0.3490196078, blue: 0.8901960784, alpha: 1)
        $0.setTitle("Settings", for: .normal)
        $0.titleEdgeInsets = .init(top: 0, left: 5, bottom: 0, right: 0)
    })
    
    private let separatorView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
    })
    
    private let profileImageView = specify(UIImageView(), {
        $0.layer.cornerRadius = 140 / 2
        $0.image = #imageLiteral(resourceName: "food8")
        $0.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.layer.borderWidth = 4
        $0.clipsToBounds = true
    })
    
    public let editProfileImageButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "profileEdit_icon"), for: .normal)
        $0.setTitleColor(.clear, for: .normal)
    })
    
    public let contactUsButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(#colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1), for: .normal)
        $0.customButton(text: "Contact Us", font: 15, weight: .regular, shadowColor: .clear, isCircled: false)
    })
    private let fullNameLabel = Label(icon: "User Test", font: .systemFont(ofSize: 22, weight: .bold),
                                      size: 22, textColor: #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1))
    
    public let generalAccountLabel = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1)
        $0.text = "General Account"
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textAlignment = .center
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        handleUI()
        addConstraints()
    }
    
    fileprivate func handleUI() {
        backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        let vTextsStackView = VStackView(arrangedSubviews: [fullNameLabel, generalAccountLabel], spacing: 20)
        
        add(settingsButton, layoutBlock: { $0.top(40).trailing(16).width(80) })
        add(contactUsButton, layoutBlock: { $0.top(35).leading(16) })
        add(profileImageView, layoutBlock: { $0.top(40).centerX().size(140) })
        profileImageView.add(editProfileImageButton, layoutBlock: { $0.bottom(15).trailing(15).size(35) })
        add(vTextsStackView, layoutBlock: { $0.topBottom(20, to: profileImageView).centerX().bottom(25) })
        add(separatorView, layoutBlock: { $0.bottom().leading().trailing().height(1) })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented UserView")
    }
}

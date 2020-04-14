//
//  UserView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1) })
    public let editProfileImageView = UIImageView(image: #imageLiteral(resourceName: "profileEdit_icon"))

    private let hideView = specify(UIView(), { $0.backgroundColor = .clear })
    
    public let mySettingsButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "settings_icon"), for: .normal)
        $0.tintColor = #colorLiteral(red: 0.5333333333, green: 0.3490196078, blue: 0.8901960784, alpha: 1)
        $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.setTitle("الإعدادات", for: .normal)
        $0.titleEdgeInsets = .init(top: 0, left: 5, bottom: 0, right: 0)
    })
    
    public let profileImageView = specify(UIImageView(), {
        $0.image = #imageLiteral(resourceName: "food8")
        $0.layer.cornerRadius = 140 / 2
        $0.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.layer.borderWidth = 5
        $0.clipsToBounds = true
    })
    
    public let contactUsButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(#colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1), for: .normal)
        $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.customButton(text: "الاتصال بنا", font: 15, weight: .regular, shadowColor: .clear,
                        isCircled: false)
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
        setupBindings()
        addConstraints()
    }
    
    fileprivate func handleUI() {
        backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        editProfileImageView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    fileprivate func setupBindings() {
    }
    
    fileprivate func addConstraints() {
        mySettingsButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        let vTextsStackView = VStackView(arrangedSubviews: [fullNameLabel, generalAccountLabel], spacing: 20)
        let hButtonsStackView = HStackView(arrangedSubviews: [contactUsButton, UIView(), mySettingsButton])
        
        add(hButtonsStackView, layoutBlock: { $0.top(Constants.sH_812 ? 60 : 40).leading(16).trailing(16) })
        add(hideView, layoutBlock: { $0.top(Constants.sH_812 ? 60 : 40).centerX().size(140) })
        hideView.add(profileImageView, layoutBlock: { $0.edges() })
        hideView.add(editProfileImageView, layoutBlock: { $0.bottom(6).leading(6).size(35) })
        add(vTextsStackView, layoutBlock: { $0.topBottom(20, to: profileImageView).centerX().bottom(25) })
        add(separatorView, layoutBlock: { $0.bottom().leading().trailing().height(1) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

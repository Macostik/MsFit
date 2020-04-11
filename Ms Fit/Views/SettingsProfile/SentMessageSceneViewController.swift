//  
//  SentMessageSceneViewController.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 09.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SentMessageSceneViewController: BaseViewController<SentMessageSceneViewModel> {
    
    private let doneButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "Done", font: 20, weight: .bold, shadowColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), bgColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), isCircled: true)
    })
    
    private let sentImageView = specify(UIImageView(), {
        $0.image = UIImage(named: "sentMessage_icon")
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.contentMode = .scaleAspectFit
    })
    
    private let thankYouLabel = specify(UILabel(), {
        $0.text = "Thank you"
        $0.font = .systemFont(ofSize: 40, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let yourRequestLabel = specify(UILabel(), {
        $0.text = "Your request sent, We well send you an answer on"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 22 : 20, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    })
    
    private let yourEmailLabel = specify(UILabel(), {
        $0.text = "test.user@yopmail.com"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 20 : 17, weight: .regular)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.textColor = #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1)
        $0.textAlignment = .center
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        doneButton.animateWhenPressed(disposeBag: disposeBag)
        doneButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        doneButton.heightAnchor.constraint(equalToConstant: Constants.sW / 5).isActive = true
        
        let baseVStackView = VStackView(arrangedSubviews: [
            VStackView(arrangedSubviews: [sentImageView, thankYouLabel],
                       spacing: Constants.sH_812 ? 120 : Constants.sH_667 ? 80 : 60),
            VStackView(arrangedSubviews: [
                VStackView(arrangedSubviews: [yourRequestLabel, yourEmailLabel], spacing: 10), doneButton
            ], spacing: Constants.sH_812 ? 120 : Constants.sH_667 ? 80 : 60)
        ], spacing: Constants.sH_812 ? 120 : Constants.sH_667 ? 80 : 60)
        
        view.add(baseVStackView, layoutBlock: { $0.leading(16).trailing(16).center() })
    }
}

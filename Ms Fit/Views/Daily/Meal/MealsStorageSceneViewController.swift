//  
//  MealsStorageSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 11.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MealsStorageSceneViewController: BaseViewController<MealsStorageSceneViewModel> {
    
    private let caloriesView = CaloriesView()
    
    private var isAnimationCalories = false
    private var heightCaloriesLayout: NSLayoutConstraint?
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(shadowColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), bgColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let navLabel = specify(UILabel(), {
        $0.text = "My meals"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let containerForButtonView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    })
    
    private let clearAllMeals = specify(UIButton(type: .roundedRect), {
        $0.layer.borderColor = #colorLiteral(red: 0.4309999943, green: 0.4309999943, blue: 0.474999994, alpha: 1)
        $0.layer.borderWidth = 0.3
        $0.setTitleColor(#colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), for: .normal)
        $0.customButton(text: "Clear All", font: 14, weight: .bold, shadowColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1),
                        bgColor: .systemBackground, isCircled: true)
    })
    
    override func setupUI() {
       handleUI()
       addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
        
        clearAllMeals.rx.tap
            .subscribe(onNext: { _ in
                print("tap")
            }).disposed(by: disposeBag)
        
        caloriesView.chevronDownButton.rx.tap
        .subscribe(onNext: { [unowned self] _ in
            self.heightCaloriesLayout?.isActive = false
            UIView.animate(withDuration: 0.3) {
                self.heightCaloriesLayout?.constant = self.isAnimationCalories ? 80 : 140
                self.heightCaloriesLayout?.isActive = true
                self.caloriesView.chevronDownButton.transform = self.isAnimationCalories ?
                    CGAffineTransform.identity : CGAffineTransform(rotationAngle: -.pi)
                self.view.layoutIfNeeded()
            }
            self.isAnimationCalories = !self.isAnimationCalories
        }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    fileprivate func addConstraints() {
        heightCaloriesLayout = caloriesView.heightAnchor.constraint(equalToConstant: 80)
        heightCaloriesLayout?.isActive = true

        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        view.add(caloriesView, layoutBlock: { $0.topBottom(to: navigationView).leading().trailing() })
        
        view.add(containerForButtonView, layoutBlock: { $0.leading().topBottom(to: caloriesView).trailing() })
        containerForButtonView.add(clearAllMeals, layoutBlock: { $0.top(8).bottom(8).leading(16).width(100) })
        view.add(closeButton, layoutBlock: { $0.bottom(25).leading(25).size(56) })
    }
}
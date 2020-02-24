//  
//  DailySceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DailySceneViewController: BaseViewController<DailySceneViewModel> {
    
    private let mealsImage = UIImageView(image: #imageLiteral(resourceName: "daily_Meals_Icon"))
    private let exerciseImage = UIImageView(image: #imageLiteral(resourceName: "dayli_Exercises"))
    
    private let bgDayliCircleImage = specify(UIImageView(image: #imageLiteral(resourceName: "dailyCircle")), {
        $0.layer.shadowColor = #colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: 5)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.5
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let exerciseContainerView = specify(UIView(), {
        $0.isUserInteractionEnabled = false
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.backgroundColor = .clear
    })
    
    private let mealsContainerView = specify(UIView(), {
        $0.isUserInteractionEnabled = false
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.backgroundColor = .clear
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "Daily workout today?"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 17 : 16, weight: .regular)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })
    
    private let middletextLabel = specify(UILabel(), {
        $0.text = "It's not a great day \nuntil you workout!"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 18 : 16, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    })
    
    private let dayliMealsLabel = specify(UILabel(), {
        $0.text = "Diet"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 22 : 18, weight: .bold)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })
    
    private let dayliExerciseLabel = specify(UILabel(), {
        $0.text = "Workout"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 22 : 18, weight: .bold)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })
    
    private let countMealsLabel = specify(UILabel(), {
        $0.text = "3 meals"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 14 : 12, weight: .regular)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })
    
    private let countExerciseLabel = specify(UILabel(), {
        $0.text = "6 exercises"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 14 : 12, weight: .regular)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })
    
    private let vExerciseStackView = specify(UIStackView(), {
        $0.axis = .vertical
    })
    
    private let vMealsStackView = specify(UIStackView(), {
        $0.axis = .vertical
    })
    
    private let hWorkoutAndDietStackView = specify(UIStackView(), {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 25
    })
    
    private let hNavStackView = specify(UIStackView(), {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 10
    })

    private let verificationEmailButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(#colorLiteral(red: 0.3799999952, green: 0.2860000134, blue: 0.7960000038, alpha: 1), for: .normal)
        $0.customButton(text: "Ver-tion", font: 16, weight: .medium,
                        shadowColor: #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1), bgColor: .systemBackground)
    })
    
    private let questionButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(#colorLiteral(red: 0.3799999952, green: 0.2860000134, blue: 0.7960000038, alpha: 1), for: .normal)
        $0.customButton(text: "?", font: 22, weight: .bold, shadowColor: #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1), bgColor: .systemBackground)
    })
    
    private let homeButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "Home", font: 16, weight: .bold)
    })
    
    private let exerciseWorkoutButton = specify(UIButton(type: .roundedRect), {
        $0.customButton(shadowColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), bgColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1))
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 6)
    })
    
    private let mealsDietButton = specify(UIButton(type: .roundedRect), {
        $0.customButton(shadowColor: #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1), bgColor: #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1))
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 6)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        homeButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
        questionButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
        verificationEmailButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
        
        exerciseWorkoutButton.animateWhenPressed(disposeBag: disposeBag)
        exerciseWorkoutButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
        
        mealsDietButton.animateWhenPressed(disposeBag: disposeBag)
        mealsDietButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.9800000191, blue: 0.9800000191, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : 80)
        })
        hNavStackView.addArrangedSubview(verificationEmailButton)
        hNavStackView.addArrangedSubview(navTextLabel)
        hWorkoutAndDietStackView.addArrangedSubview(mealsDietButton)
        hWorkoutAndDietStackView.addArrangedSubview(exerciseWorkoutButton)
        vMealsStackView.addArrangedSubview(dayliMealsLabel)
        vMealsStackView.addArrangedSubview(countMealsLabel)
        exerciseImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        vExerciseStackView.addArrangedSubview(dayliExerciseLabel)
        vExerciseStackView.addArrangedSubview(countExerciseLabel)
        navigationView.add(hNavStackView, layoutBlock: { $0.leading(16).trailing(16).bottom(14) })
        view.add(bgDayliCircleImage, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing()
                .height(Constants.sH_812 ? Constants.sW * 0.7 : Constants.sW * 0.6)
        })
        view.add(questionButton, layoutBlock: { $0.topBottom(20, to: navigationView).trailing(16).size(30) })
        view.add(homeButton, layoutBlock: { $0.topBottom(15, to: navigationView).leading(16) })
        view.add(hWorkoutAndDietStackView, layoutBlock: {
            $0.bottom(tabBarHeight + (Constants.sH_812 ? 50 : 30)).trailing(25).leading(25).height(150)
        })
        view.add(middletextLabel, layoutBlock: {
            $0.bottomTop(Constants.sH_667 ? -50 : -20 , to: hWorkoutAndDietStackView).leading(20).trailing(20)
        })
        exerciseContainerView.add(exerciseImage, layoutBlock: { $0.top().centerX().height(34).width(40) })
        exerciseContainerView.add(vExerciseStackView, layoutBlock: {
            $0.topBottom(8, to: exerciseImage).leading().trailing().bottom()
        })
        mealsContainerView.add(mealsImage, layoutBlock: { $0.top().centerX().height(34).width(40) })
        mealsContainerView.add(vMealsStackView, layoutBlock: {
            $0.topBottom(8, to: mealsImage).leading().trailing().bottom()
        })
        mealsDietButton.add(mealsContainerView, layoutBlock: { $0.center() })
        exerciseWorkoutButton.add(exerciseContainerView, layoutBlock: { $0.center() })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}

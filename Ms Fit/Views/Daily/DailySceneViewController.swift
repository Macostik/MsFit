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
    
    private let verificationView = VerificationEmailPopupView()
    
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
    })
    
    private let exerciseContainerView = specify(UIView(), {
        $0.isUserInteractionEnabled = false
        $0.backgroundColor = .clear
    })
    
    private let mealsContainerView = specify(UIView(), {
        $0.isUserInteractionEnabled = false
        $0.backgroundColor = .clear
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "تجريب يومي اليوم؟"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 17 : 16, weight: .regular)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })
    
    private let middletextLabel = specify(UILabel(), {
        $0.text = "اعرفي مستواك باختبار مدته 3 دقائقأو اختاري المستوى المبتدئ إذا أول مرة تمارسين الرياضة"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 18 : 16, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    })
    
    private let dayliMealsLabel = specify(UILabel(), {
        $0.text = "وجباتي"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 22 : 18, weight: .bold)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })
    
    private let dayliExerciseLabel = specify(UILabel(), {
        $0.text = "تماريني"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 22 : 18, weight: .bold)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })
    
    private let countMealsLabel = specify(UILabel(), {
        $0.text = "0 وجبات"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 14 : 12, weight: .regular)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })
    
    private let countExerciseLabel = specify(UILabel(), {
        $0.text = "0 تمارين"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 14 : 12, weight: .regular)
        $0.textColor = .systemBackground
        $0.textAlignment = .center
    })

    private let verificationEmailButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        $0.setTitleColor(#colorLiteral(red: 0.3799999952, green: 0.2860000134, blue: 0.7960000038, alpha: 1), for: .normal)
        $0.setTitle("التحقق", for: .normal)
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = (Constants.sH_667 ? 40 : 30) / 2
        $0.layer.shadowColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = .init(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    })
    
    private let questionButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.setTitleColor(#colorLiteral(red: 0.3799999952, green: 0.2860000134, blue: 0.7960000038, alpha: 1), for: .normal)
        $0.setTitle("?", for: .normal)
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 15
        $0.layer.shadowColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = .init(width: 0, height: 3)
        $0.layer.shadowRadius = 4
    })
    
    private let homeButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "الاشتراك", font: 16, weight: .bold)
    })
    
    private let exerciseWorkoutButton = specify(UIButton(type: .roundedRect), {
        $0.layer.shadowColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.layer.cornerRadius = (Constants.sW * 0.4) / 2
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 6)
    })
    
    private let mealsDietButton = specify(UIButton(type: .roundedRect), {
        $0.layer.shadowColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1)
        $0.layer.cornerRadius = (Constants.sW * 0.4) / 2
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 6)
    })
    
    private let baseView = specify(UIView(), { $0.backgroundColor = .clear })
    
    private let daysLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.text = "6"
    })
    
    private let dayLabel = specify(UILabel(), {
        $0.text = "يوم"
        $0.font = .systemFont(ofSize: 22, weight: .medium)
        $0.textAlignment = .center
        $0.textColor = #colorLiteral(red: 0.7254901961, green: 0.6823529412, blue: 1, alpha: 1)
    })
    
    private let leftLabel = specify(UILabel(), {
        $0.text = "باقي"
        $0.font = .systemFont(ofSize: 22, weight: .medium)
        $0.textAlignment = .center
        $0.textColor = #colorLiteral(red: 0.7254901961, green: 0.6823529412, blue: 1, alpha: 1)
    })
    
    private let zeroView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let oneView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let twoView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let threeView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1058823529, blue: 0.1529411765, alpha: 0.2972495719)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let fourView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1058823529, blue: 0.1529411765, alpha: 0.2972495719)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let fiveView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let sixView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    
    private let sevenView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1058823529, blue: 0.1529411765, alpha: 0.2972495719)
        $0.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    
    private let eightView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1058823529, blue: 0.1529411765, alpha: 0.2972495719)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let nineView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1058823529, blue: 0.1529411765, alpha: 0.2972495719)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let tenView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let elevenView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let twelveView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let threeteenView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1058823529, blue: 0.1529411765, alpha: 0.2972495719)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
    private let fourteenView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1058823529, blue: 0.1529411765, alpha: 0.2972495719)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    })
        
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        homeButton.rx.tap
            .bind(to: viewModel!.homePresentObserver)
            .disposed(by: disposeBag)
        questionButton.rx.tap
            .bind(to: viewModel!.questionPresentObserver)
            .disposed(by: disposeBag)
        
        verificationEmailButton.rx.tap
            .subscribe(onNext: { _ in
                rootViewController?.add(self.verificationView, layoutBlock: { $0.edges() })
                self.verificationView.alpha = 0
                self.verificationView.containerView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.verificationView.alpha = 1
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                    self.verificationView.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }).disposed(by: disposeBag)
        
        exerciseWorkoutButton.animateWhenPressed(disposeBag: disposeBag)
        exerciseWorkoutButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.presentWorkoutObserver)
            .disposed(by: disposeBag)
        
        mealsDietButton.animateWhenPressed(disposeBag: disposeBag)
        mealsDietButton.rx.tap
            .bind(to: viewModel!.presentMealObserver)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.9800000191, blue: 0.9800000191, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        verificationEmailButton.heightAnchor.constraint(equalToConstant:
            Constants.sH_667 ? 40 : 30).isActive = true
        exerciseWorkoutButton.widthAnchor.constraint(equalToConstant: Constants.sW * 0.4).isActive = true
        exerciseWorkoutButton.heightAnchor.constraint(equalToConstant: Constants.sW * 0.4).isActive = true
        
        let hNavStackView = HStackView(arrangedSubviews: [navTextLabel, verificationEmailButton], spacing: 10)
        hNavStackView.distribution = .fillProportionally
        
        let hWorkoutAndDietStackView = HStackView(arrangedSubviews: [mealsDietButton, exerciseWorkoutButton],
                                                  spacing: 25)
        hWorkoutAndDietStackView.distribution = .fillEqually
        
        let vMealsStackView = VStackView(arrangedSubviews: [dayliMealsLabel, countMealsLabel])
        let vExerciseStackView = VStackView(arrangedSubviews: [dayliExerciseLabel, countExerciseLabel])
        
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(hNavStackView, layoutBlock: {
            $0.leading(16).trailing(16).bottom(Constants.sH_812 ? 15 : 10)
        })
        view.add(bgDayliCircleImage, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing()
                .height(Constants.sH_812 ? Constants.sW * 0.8 : Constants.sW * 0.7)
        })
        
        // start circle days
        bgDayliCircleImage.add(baseView, layoutBlock: { $0.centerX().centerY().size(Constants.sW / 1.9) })
        
        baseView.add(zeroView, layoutBlock: { $0.centerX().top().size(16) })
        baseView.add(oneView, layoutBlock: {
            $0.centerX(Constants.sW * 0.11).centerY(Constants.sW * -0.21).size(16)
        })
        baseView.add(twoView, layoutBlock: {
            $0.centerX(Constants.sW * 0.19).centerY(Constants.sW * -0.14).size(16)
        })
        baseView.add(threeView, layoutBlock: {
            $0.trailing(1).bottomCenterY(Constants.sW * -0.03, to: baseView).size(16)
        })
        baseView.add(fourView, layoutBlock: {
            $0.trailing(1).topCenterY(Constants.sW * 0.03, to: baseView).size(16)
        })
        baseView.add(fiveView, layoutBlock: {
            $0.centerX(Constants.sW * 0.19).centerY(Constants.sW * 0.14).size(16)
        })
        baseView.add(sixView, layoutBlock: {
            $0.centerX(Constants.sW * 0.11).centerY(Constants.sW * 0.21).size(16)
        })
        //----- middle
        baseView.add(sevenView, layoutBlock: { $0.centerX().bottom().size(16) })
        //----- middle
        baseView.add(eightView, layoutBlock: {
            $0.centerX(Constants.sW * -0.11).centerY(Constants.sW * 0.21).size(16)
        })
        baseView.add(nineView, layoutBlock: {
            $0.centerX(Constants.sW * -0.19).centerY(Constants.sW * 0.14).size(16)
        })
        baseView.add(tenView, layoutBlock: {
            $0.leading(-1).topCenterY(Constants.sW * 0.03, to: baseView).size(16)
        })
        baseView.add(elevenView, layoutBlock: {
            $0.leading(-1).bottomCenterY(Constants.sW * -0.03, to: baseView).size(16)
        })
        baseView.add(threeteenView, layoutBlock: {
            $0.centerX(Constants.sW * -0.19).centerY(Constants.sW * -0.14).size(16)
        })
        baseView.add(fourteenView, layoutBlock: {
            $0.centerX(Constants.sW * -0.11).centerY(Constants.sW * -0.21).size(16)
        })
        baseView.add(daysLabel, layoutBlock: { $0.center() })
        baseView.add(dayLabel, layoutBlock: { $0.centerX().topBottom(-14, to: daysLabel) })
        baseView.add(leftLabel, layoutBlock: { $0.centerX().bottomTop(4, to: daysLabel) })
        //end circle days
        
        view.add(questionButton, layoutBlock: { $0.topBottom(20, to: navigationView).trailing(16).size(30) })
        view.add(homeButton, layoutBlock: { $0.topBottom(15, to: navigationView).leading(16) })
        view.add(hWorkoutAndDietStackView, layoutBlock: {
            $0.bottom(tabBarHeight + (Constants.sH_812 ? 50 : 30)).centerX()
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
}

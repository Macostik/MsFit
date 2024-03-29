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
    private let daysOfCircle = DaysOfCircleView()
    
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
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 18 : Constants.sH_667 ? 16 : 14, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    })
    
    private let getTextLabel = specify(UILabel(), {
        $0.text = "اعرفي مستواك باختبار مدته 3 دقائقأو اختاري المستوى المبتدئ إذا أول مرة تمارسين الرياضة"
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 18 : Constants.sH_667 ? 16 : 14, weight: .regular)
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
    
    private var vFreeDaysVStackView: UIStackView!
    private var vWorkoutAndDietStackView: UIStackView!

    private let verificationEmailButton = specify(UIButton(type: .roundedRect), {
        $0.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        $0.setTitleColor(#colorLiteral(red: 0.3799999952, green: 0.2860000134, blue: 0.7960000038, alpha: 1), for: .normal)
        $0.setTitle("التحقق", for: .normal)
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 30/2
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
        $0.layer.cornerRadius = 35/2
        $0.layer.shadowColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = .init(width: 0, height: 3)
        $0.layer.shadowRadius = 4
    })
    
    private let homeButton = specify(UIButton(type: .roundedRect), {
        $0.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
        $0.titleLabel?.font = .systemFont(ofSize: Constants.sH_667 ? 16 : 14, weight: .bold)
        $0.isHidden = true
        $0.setTitleColor(#colorLiteral(red: 0.3799999952, green: 0.2860000134, blue: 0.7960000038, alpha: 1), for: .normal)
        $0.setTitle("الاشتراك", for: .normal)
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 35/2
        $0.layer.shadowColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = .init(width: 0, height: 3)
        $0.layer.shadowRadius = 4
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
    
    private let generalProgramButton = specify(UIButton(type: .roundedRect), {
        $0.setTitle("ابدأ التجربة لمدة 3 أيام", for: .normal)
        $0.layer.cornerRadius = (Constants.sW * 0.15) / 2
        $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.tintColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.layer.shadowColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowRadius = 2
    })
    
    private let testMeButton = specify(UIButton(type: .roundedRect), {
        $0.customButton(text: "اختبار", font: 20, weight: .bold,
                        shadowColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), bgColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), isCircled: true)
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
        
        testMeButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel?.presentPreviewStartObserver.onNext(())
            }).disposed(by: disposeBag)
        
        generalProgramButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel?.presentGeneralProgramObserver.onNext(())
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.vWorkoutAndDietStackView.isHidden = false
                    self.vFreeDaysVStackView.isHidden = true
                    self.homeButton.isHidden = false
                })
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.9800000191, blue: 0.9800000191, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        verificationEmailButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        exerciseWorkoutButton.widthAnchor.constraint(equalToConstant: Constants.sW * 0.4).isActive = true
        exerciseWorkoutButton.heightAnchor.constraint(equalToConstant: Constants.sW * 0.4).isActive = true
        testMeButton.heightAnchor.constraint(equalToConstant: Constants.sW * 0.15).isActive = true
        generalProgramButton.heightAnchor.constraint(equalToConstant: Constants.sW * 0.15).isActive = true
        
        let hNavStackView = HStackView(arrangedSubviews: [navTextLabel, verificationEmailButton], spacing: 10)
        hNavStackView.distribution = .fill
        
        let hWorkoutAndDietStackView = HStackView(arrangedSubviews: [
            mealsDietButton, exerciseWorkoutButton
            ], spacing: 25)
        hWorkoutAndDietStackView.distribution = .fillEqually
        
        vWorkoutAndDietStackView = VStackView(arrangedSubviews: [
            middletextLabel, hWorkoutAndDietStackView
        ], spacing: Constants.sH_812 ? 60 : Constants.sH_667 ? 50 : 20)
        
        vFreeDaysVStackView = VStackView(arrangedSubviews: [
            getTextLabel, VStackView(arrangedSubviews: [testMeButton, generalProgramButton], spacing: 25)
        ], spacing: Constants.sH_812 ? 60 : Constants.sH_667 ? 50 : 20)
        
        vWorkoutAndDietStackView.isHidden = true
        vFreeDaysVStackView.isHidden = false
        
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
        
        //add days of circle
        bgDayliCircleImage.add(daysOfCircle, layoutBlock: { $0.centerX().centerY().size(Constants.sW / 1.9) })

        view.add(questionButton, layoutBlock: { $0.topBottom(20, to: navigationView).trailing(16).size(35) })
        view.add(homeButton, layoutBlock: {
            $0.topBottom(15, to: navigationView).leading(16).height(35)
        })
        view.add(vWorkoutAndDietStackView, layoutBlock: {
            $0.bottom(tabBarHeight + (Constants.sH_812 ? 50 : 30)).centerX()
        })
        
        view.add(vFreeDaysVStackView, layoutBlock: {
            $0.bottom(tabBarHeight + (Constants.sH_812 ? 60 : 30)).trailing(20).leading(20)
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

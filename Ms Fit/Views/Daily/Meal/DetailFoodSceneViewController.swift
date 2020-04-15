//  
//  DetailFoodSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 31.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailFoodSceneViewController: BaseViewController<DetailFoodSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let scrollView = specify(UIScrollView(), {
        $0.showsVerticalScrollIndicator = false
    })
    
    private let gradientView = specify(GradientView(), {
        $0.isUserInteractionEnabled = false
        $0.topColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.3)
        $0.bottomColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.01)
        $0.startPointX = 0.8
        $0.startPointY = 0.4
        $0.endPointX = 0.8
        $0.endPointY = 0.8
    })
    
    private let imageView = specify(UIImageView(), {
        $0.image = #imageLiteral(resourceName: "food2")
        $0.contentMode = .scaleAspectFill
    })
    
    private let titleSeparView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    private let caloriesSeparView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    private let ingridientSeparView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    private let directionSeparView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    
    private let titleLabel = Label(icon: "صدر دجاج مع الرز",
                                   font: .systemFont(ofSize: 22, weight: .bold), textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1),
                                   isTranform: true)
    
    private let eatenLabel = Label(icon: "تؤكل", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    private let leftLabel = Label(icon: "اليسار", font: .systemFont(ofSize: 12, weight: .regular),
                                  size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    
    private let countCaloriesLabel = Label(icon: "373", font: .systemFont(ofSize: 16, weight: .medium),
                                           size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    private let countCarbsLabel = Label(icon: "57.3", font: .systemFont(ofSize: 16, weight: .medium),
                                        size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    private let countFatLabel = Label(icon: "20.6", font: .systemFont(ofSize: 16, weight: .medium),
                                      size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    private let countProtsLabel = Label(icon: "20.5", font: .systemFont(ofSize: 16, weight: .medium),
                                        size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    private let countEatenLabel = Label(icon: "440 kCal", font: .systemFont(ofSize: 12, weight: .bold),
                                        size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    private let countLeftLabel = Label(icon: "760 kCal", font: .systemFont(ofSize: 12, weight: .bold),
                                       size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    
    private let kCalCaloriesLabel = Label(icon: "kCal", font: .systemFont(ofSize: 12, weight: .regular),
                                          size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    private let gramsCarbsLabel = Label(icon: "g", font: .systemFont(ofSize: 12, weight: .regular),
                                        size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    private let gramsFatLabel = Label(icon: "g", font: .systemFont(ofSize: 12, weight: .regular),
                                      size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    private let gramsProtsLabel = Label(icon: "g", font: .systemFont(ofSize: 12, weight: .regular),
                                        size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: true)
    
    private let caloriesLabel = Label(icon: "السعرات", font: .systemFont(ofSize: 12, weight: .regular),
                                      size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), isTranform: true, textAlignment: .center)
    private let carbsLabel = Label(icon: "الكارب", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), isTranform: true, textAlignment: .center)
    private let fatLabel = Label(icon: "الدهون", font: .systemFont(ofSize: 12, weight: .regular),
                                 size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), isTranform: true, textAlignment: .center)
    private let protsLabel = Label(icon: "البروتين", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), isTranform: true, textAlignment: .center)
    
    private let ingredientsLabel = Label(icon: "الكميّـة", font: .systemFont(ofSize: 16, weight: .bold),
                                         textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: false, textAlignment: .right)
    private let directionLabel = Label(icon: "ملاحظات", font: .systemFont(ofSize: 16, weight: .bold),
                                       textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: false, textAlignment: .right)
    
    private let ingrediDiscripLabel = specify(UILabel(), {
        $0.text = """
        • Rais - 100g.\n
        • Egs - 1 slices.\n
        • Oil - 1 tea spoon
        """
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    })
    
    private let directionDiscripLabel = specify(UILabel(), {
        $0.text = """
        - That may speed up results.\n
        - Let’s face it: The rules of weight\n
        - Let’s face it: The rules of weight
        """
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    })
    
    private let addMealButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "أضف", font: 14, weight: .bold, shadowColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1),
                        bgColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), isCircled: true)
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
        
        addMealButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
        
        scrollView.rx.contentOffset
            .subscribe(onNext: { offset in
                self.scrollView.contentOffset.y =
                    offset.y < 0.0 ? 0.0 : self.scrollView.contentOffset.y
            }).disposed(by: disposeBag)
        
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = .systemBackground
    }
    
    fileprivate func addConstraints() {
        view.add(scrollView, layoutBlock: { $0.top().bottom().width(Constants.sW) })
        view.add(gradientView, layoutBlock: { $0.top().leading().trailing().height(70) })
        view.add(closeButton, layoutBlock: { $0.top(10).leading(10).size(44) })
        
        titleSeparView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        ingridientSeparView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        directionSeparView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let titleVStackView = VStackView(arrangedSubviews: [titleLabel, titleSeparView ], spacing: 20)
        
        let hCaloriesStackView = HStackView(arrangedSubviews: [
            VStackView(arrangedSubviews: [
              caloriesLabel, HStackView(arrangedSubviews: [countCaloriesLabel, kCalCaloriesLabel], spacing: 2)
            ], spacing: 5),
            VStackView(arrangedSubviews: [
                carbsLabel, HStackView(arrangedSubviews: [countCarbsLabel, gramsCarbsLabel], spacing: 2)
            ], spacing: 5),
            VStackView(arrangedSubviews: [
                fatLabel, HStackView(arrangedSubviews: [countFatLabel, gramsFatLabel], spacing: 2)
            ], spacing: 5),
            VStackView(arrangedSubviews: [
                protsLabel, HStackView(arrangedSubviews: [countProtsLabel, gramsProtsLabel], spacing: 2)
            ], spacing: 5)
        ], spacing: Constants.sH_812 ? 40 : Constants.sH_667 ? 30 : 20)
        hCaloriesStackView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        let ingridVStackView = VStackView(arrangedSubviews: [
            ingredientsLabel, ingrediDiscripLabel, ingridientSeparView
        ], spacing: 20)
        
        let directionVStackView = VStackView(arrangedSubviews: [
            directionLabel, directionDiscripLabel, directionSeparView
        ], spacing: 20)
        
        let baseVStackView = VStackView(arrangedSubviews: [
            ingridVStackView, directionVStackView
        ], spacing: 20)
        
        scrollView.add(imageView, layoutBlock: { $0.top().width(Constants.sW).height(Constants.sW * 0.7) })
        scrollView.add(titleVStackView, layoutBlock: {
            $0.topBottom(20, to: imageView).width(Constants.sW - 32).centerX()
        })
        scrollView.add(hCaloriesStackView, layoutBlock: { $0.topBottom(20, to: titleVStackView).centerX() })
        scrollView.add(caloriesSeparView, layoutBlock: {
            $0.topBottom(5, to: hCaloriesStackView).width(Constants.sW - 32).height(1).centerX()
        })
        
        scrollView.add(baseVStackView, layoutBlock: {
            $0.topBottom(20, to: caloriesSeparView).width(Constants.sW - 32).centerX()
        })
        scrollView.add(addMealButton, layoutBlock: {
            $0.topBottom(20, to: baseVStackView).width(Constants.sW - 32)
                .centerX().height(Constants.sW / 6.5).bottom(10)
        })
    }
}

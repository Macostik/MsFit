//  
//  MealDetailSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 27.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MealDetailSceneViewController: BaseViewController<MealDetailSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let heartConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var heartButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "suit.heart.fill", withConfiguration: heartConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let scrollView = specify(UIScrollView(), {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
    })
    
    private let feedImageView = specify(UIImageView(), { $0.image = #imageLiteral(resourceName: "food3") })
    
    private let titleSeparView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    private let caloriesSeparView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    private let ingridientSeparView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    private let directionSeparView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    
    private let titleLabel = Label(icon: "Chicken breast with rice",
                                   font: .systemFont(ofSize: 22, weight: .bold), textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let eatenLabel = Label(icon: "Eaten", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let leftLabel = Label(icon: "Left", font: .systemFont(ofSize: 12, weight: .regular),
                                  size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let countCaloriesLabel = Label(icon: "373", font: .systemFont(ofSize: 16, weight: .medium),
                                           size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let countCarbsLabel = Label(icon: "57.3", font: .systemFont(ofSize: 16, weight: .medium),
                                        size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let countFatLabel = Label(icon: "20.6", font: .systemFont(ofSize: 16, weight: .medium),
                                      size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let countProtsLabel = Label(icon: "20.5", font: .systemFont(ofSize: 16, weight: .medium),
                                        size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let countEatenLabel = Label(icon: "440 kCal", font: .systemFont(ofSize: 12, weight: .bold),
                                        size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let countLeftLabel = Label(icon: "760 kCal", font: .systemFont(ofSize: 12, weight: .bold),
                                       size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let kCalCaloriesLabel = Label(icon: "kCal", font: .systemFont(ofSize: 12, weight: .regular),
                                          size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let gramsCarbsLabel = Label(icon: "g", font: .systemFont(ofSize: 12, weight: .regular),
                                        size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let gramsFatLabel = Label(icon: "g", font: .systemFont(ofSize: 12, weight: .regular),
                                      size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let gramsProtsLabel = Label(icon: "g", font: .systemFont(ofSize: 12, weight: .regular),
                                        size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let caloriesLabel = Label(icon: "CALORIES", font: .systemFont(ofSize: 12, weight: .regular),
                                      size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    private let carbsLabel = Label(icon: "CARBS", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    private let fatLabel = Label(icon: "FAT", font: .systemFont(ofSize: 12, weight: .regular),
                                 size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    private let protsLabel = Label(icon: "PROTS", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    
    private let ingredientsLabel = Label(icon: "Ingredients", font: .systemFont(ofSize: 16, weight: .bold),
                                         textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let directionLabel = Label(icon: "Directions", font: .systemFont(ofSize: 16, weight: .bold),
                                       textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let ingrediDiscripLabel = specify(UILabel(), {
        $0.text = """
        • Rais - 100g.\n
        • Egs - 1 slices.\n
        • Oil - 1 tea spoon 😕\n
        • that may speed up results. 🥤🍀\n
        • The rules of weight loss—eat less.\n
        • And they don’t fit with most  🍋\n
        • Let’s face it: The rules of weight 💪
        """
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    })
    
    private let directionDiscripLabel = specify(UILabel(), {
        $0.text = """
        - That may speed up results.\n
        - Let’s face it: The rules of weight\n
        - And they don’t fit with most 💪😍😕\n
        - that may speed up results. 🥤🍀\n
        - The rules of weight loss—eat less. ❌\n
        - And they don’t fit with most  🍋\n
        - Let’s face it: The rules of weight 😕
        """
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    })
    
    private let countMealsLabel = specify(UILabel(), {
        $0.text = "4"
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.textAlignment = .center
        $0.textColor = .systemBackground
        $0.backgroundColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
        $0.font = .systemFont(ofSize: 10, weight: .bold)
    })
    
    private let mealsSupplementsLabel = Label(icon: "Meals supplements",
                                              font: .systemFont(ofSize: 16, weight: .bold), textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let addMealButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "Add", font: 14, weight: .bold, shadowColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1),
                        bgColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), isCircled: true)
    })
    
    private let fruitLabel = specify(UILabel(), {
        $0.text = "Fruit"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    private let fruitImageView = specify(UIImageView(), { $0.image = #imageLiteral(resourceName: "grape_icon") })
    private let fruitView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = (Constants.sW / 6.5) / 2
        $0.layer.shadowColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: -0.3)
        $0.layer.shadowOpacity = 0.3
    })
    
    private let drinkLabel = specify(UILabel(), {
        $0.text = "Drink"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let drinkImageView = specify(UIImageView(), { $0.image = #imageLiteral(resourceName: "smoothie_icon") })
    private let drinkView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = (Constants.sW / 6.5) / 2
        $0.layer.shadowColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: -0.3)
        $0.layer.shadowOpacity = 0.3
    })
    
    private let saucesLabel = specify(UILabel(), {
        $0.text = "Sauces"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let saucesImageView = specify(UIImageView(), { $0.image = #imageLiteral(resourceName: "ketchup_icon") })
    private let saucesView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = (Constants.sW / 6.5) / 2
        $0.layer.shadowColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: -0.3)
        $0.layer.shadowOpacity = 0.3
    })
    
    private let snackLabel = specify(UILabel(), {
        $0.text = "Snacks"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let snackImageView = specify(UIImageView(), { $0.image = #imageLiteral(resourceName: "snack_icon") })
    private let snackView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = (Constants.sW / 6.5) / 2
        $0.layer.shadowColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: -0.3)
        $0.layer.shadowOpacity = 0.3
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
        
        scrollView.rx.contentOffset
            .subscribe(onNext: { [unowned self] offset in
                self.scrollView.contentOffset.y =
                    offset.y < 0.0 ? 0.0 : self.scrollView.contentOffset.y
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(scrollView, layoutBlock: { $0.top().width(Constants.sW).bottom() })
        view.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).leading(4).size(44)
        })
        view.add(heartButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).trailing(4).size(44)
        })
        
        fruitView.heightAnchor.constraint(equalToConstant: Constants.sW / 6.5).isActive = true
        fruitView.widthAnchor.constraint(equalToConstant: Constants.sW / 6.5).isActive = true
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
                
        let hStackViewForButtons = HStackView(arrangedSubviews: [
            VStackView(arrangedSubviews: [fruitView, fruitLabel], spacing: 5),
            VStackView(arrangedSubviews: [drinkView, drinkLabel], spacing: 5),
            VStackView(arrangedSubviews: [saucesView, saucesLabel], spacing: 5),
            VStackView(arrangedSubviews: [snackView, snackLabel], spacing: 5)
        ], spacing: 25)
        hStackViewForButtons.distribution = .fillEqually
        hStackViewForButtons.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        fruitView.add(fruitImageView, layoutBlock: { $0.edges(10) })
        fruitView.add(countMealsLabel, layoutBlock: { $0.top(1).leading(1).size(16) })
        drinkView.add(drinkImageView, layoutBlock: { $0.edges(10) })
        saucesView.add(saucesImageView, layoutBlock: { $0.edges(10) })
        snackView.add(snackImageView, layoutBlock: { $0.edges(10) })
        
        scrollView.add(feedImageView, layoutBlock: { $0.top().width(Constants.sW).height(Constants.sW * 0.7)})
        scrollView.add(titleVStackView, layoutBlock: {
            $0.topBottom(20, to: feedImageView).width(Constants.sW - 32).centerX()
        })
        scrollView.add(hCaloriesStackView, layoutBlock: { $0.topBottom(20, to: titleVStackView).centerX() })
        scrollView.add(caloriesSeparView, layoutBlock: {
            $0.topBottom(10, to: hCaloriesStackView).width(Constants.sW - 32).height(1).centerX()
        })
        scrollView.add(ingridVStackView, layoutBlock: {
            $0.centerX().width(Constants.sW - 32).topBottom(20, to: caloriesSeparView)
        })
        
        scrollView.add(directionVStackView, layoutBlock: {
            $0.centerX().width(Constants.sW - 32).topBottom(20, to: ingridVStackView)
        })
        
        scrollView.add(mealsSupplementsLabel, layoutBlock: {
            $0.leading(16).topBottom(20, to: directionVStackView)
        })
        
        scrollView.add(hStackViewForButtons, layoutBlock: {
            $0.centerX().topBottom(16, to: mealsSupplementsLabel)
        })
        
        scrollView.add(addMealButton, layoutBlock: {
            $0.topBottom(60, to: hStackViewForButtons).bottom(Constants.sH_812 ? 50 : 30).centerX()
                .width(Constants.sW - 32).height(Constants.sW / 6.5)
        })
    }
}

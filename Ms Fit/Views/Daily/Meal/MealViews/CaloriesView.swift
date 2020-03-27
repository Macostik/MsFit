//
//  CaloriesView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CaloriesView: UIView {
    
    private let countCaloriesLabel = Label(icon: "1200/1200", font: .systemFont(ofSize: 16, weight: .medium),
                                           size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let countCarbsLabel = Label(icon: "1659.5", font: .systemFont(ofSize: 16, weight: .medium),
                                        size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let countFatLabel = Label(icon: "207.5", font: .systemFont(ofSize: 16, weight: .medium),
                                      size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let countProtsLabel = Label(icon: "415.5", font: .systemFont(ofSize: 16, weight: .medium),
                                        size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let kCalCaloriesLabel = Label(icon: "kCal", font: .systemFont(ofSize: 12, weight: .regular),
                                          size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let gramsCarbsLabel = Label(icon: "g", font: .systemFont(ofSize: 12, weight: .regular),
                                        size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let gramsFatLabel = Label(icon: "g", font: .systemFont(ofSize: 12, weight: .regular),
                                      size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let gramsProtsLabel = Label(icon: "g", font: .systemFont(ofSize: 12, weight: .regular),
                                        size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let eatenLabel = Label(icon: "Eaten", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let leftLabel = Label(icon: "Left", font: .systemFont(ofSize: 12, weight: .regular),
                                  size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let countEatenLabel = Label(icon: "440 kCal", font: .systemFont(ofSize: 12, weight: .bold),
                                        size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let countLeftLabel = Label(icon: "760 kCal", font: .systemFont(ofSize: 12, weight: .bold),
                                       size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let caloriesLabel = Label(icon: "CALORIES", font: .systemFont(ofSize: 12, weight: .regular),
                                      size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    
    private let carbsLabel = Label(icon: "CARBS", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    
    private let fatLabel = Label(icon: "FAT", font: .systemFont(ofSize: 12, weight: .regular),
                                 size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    
    private let protsLabel = Label(icon: "PROTS", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .regular)
    public lazy var chevronDownButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.down", withConfiguration: mediumConfiguration)?
            .withTintColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
    })
    private let containerViewForProgress = specify(UIView(), {
        $0.backgroundColor = .systemBackground
    })
    
    private let progressView = specify(UIProgressView(), {
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.progress = 0.4
        $0.progressTintColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
        $0.layer.cornerRadius = 12/2
        $0.clipsToBounds = true
        $0.layer.sublayers![1].cornerRadius = 12/2
        $0.subviews[1].clipsToBounds = true
    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addConstraint()
        setupBindings()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .systemBackground
    }
    
    fileprivate func setupBindings() {
        
    }
    
    fileprivate func addConstraint() {
        let hEatenStackView = HStackView(arrangedSubviews: [countEatenLabel, eatenLabel], spacing: 5)
        let hLeftStackView = HStackView(arrangedSubviews: [countLeftLabel, leftLabel], spacing: 5)
        let hBaseStackView = HStackView(arrangedSubviews: [hLeftStackView, UIView(), hEatenStackView])
        let vStackView = VStackView(arrangedSubviews: [hBaseStackView, progressView], spacing: 10)
        progressView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        let vCaloriesStackView = VStackView(arrangedSubviews: [
            caloriesLabel, HStackView(arrangedSubviews: [countCaloriesLabel, kCalCaloriesLabel], spacing: 2)
        ], spacing: 5)
        
        let vCarbsStackView = VStackView(arrangedSubviews: [
            carbsLabel, HStackView(arrangedSubviews: [countCarbsLabel, gramsCarbsLabel], spacing: 2)
        ], spacing: 5)
        
        let vFatStackView = VStackView(arrangedSubviews: [
            fatLabel, HStackView(arrangedSubviews: [countFatLabel, gramsFatLabel], spacing: 2)
        ], spacing: 5)
        
        let vProtsStackView = VStackView(arrangedSubviews: [
            protsLabel, HStackView(arrangedSubviews: [countProtsLabel, gramsProtsLabel], spacing: 2)
        ], spacing: 5)
        
        let hCaloriesStackView = HStackView(arrangedSubviews: [
            vCaloriesStackView, vCarbsStackView, vFatStackView, vProtsStackView
        ], spacing: Constants.sH_812 ? 20 : Constants.sH_667 ? 15 : 10)
        
        add(chevronDownButton, layoutBlock: { $0.centerX().bottom().size(30) })
        add(hCaloriesStackView, layoutBlock: { $0.bottomTop(-4, to: chevronDownButton).centerX() })
        add(containerViewForProgress, layoutBlock: { $0.top(10).leading(16).trailing(16) })
        containerViewForProgress.add(vStackView, layoutBlock: { $0.edges() })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

//  
//  HomeSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 26.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeSceneViewController: BaseViewController<HomeSceneViewModel> {
    
    private let fullProgramImage = UIImageView(image: #imageLiteral(resourceName: "buy_three_month_icon"))
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.3607843137, blue: 0.9098039216, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let bgDayliCircleImage = specify(UIImageView(image: #imageLiteral(resourceName: "dailyCircle")), {
        $0.layer.shadowColor = #colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: 5)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.5
    })
    
    private let vOneMonthStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.spacing = 6
        $0.isUserInteractionEnabled = false
    })
    
    private let vThreeMonthStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.spacing = 6
        $0.isUserInteractionEnabled = false
    })
    
    private let oneMonthLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textAlignment = .center
        $0.text = "1 months"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let threeMonthLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textAlignment = .center
        $0.text = "3 months"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let priceOneMonthLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textAlignment = .center
        $0.text = "$15 / MONTH"
        $0.textColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    private let priceThreeMonthLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textAlignment = .center
        $0.text = "$9.99 / MONTH"
        $0.textColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
    })
    
    private let getPremiumLabel = specify(UILabel(), {
        $0.text = "Get Premium Membership"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 20 : 17, weight: .regular)
        $0.textAlignment = .center
    })
    
    private let vForButtonsStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 25
    })
    
    private let buyOneMonthButton = specify(UIButton(type: .roundedRect), {
        $0.customButton(shadowColor: #colorLiteral(red: 0.90200001, green: 0.90200001, blue: 0.90200001, alpha: 1), bgColor: .systemBackground )
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    })
    
    private let buyThreeMonthButton = specify(UIButton(type: .roundedRect), {
        $0.customButton(shadowColor: #colorLiteral(red: 0.90200001, green: 0.90200001, blue: 0.90200001, alpha: 1), bgColor: .systemBackground)
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
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
        
        buyOneMonthButton.animateWhenPressed(disposeBag: disposeBag)
        buyThreeMonthButton.animateWhenPressed(disposeBag: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        view.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.9800000191, blue: 0.9800000191, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : 80)
        })
        navigationView.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 40 : 20).leading(4).size(44)
        })
        view.add(bgDayliCircleImage, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing()
                .height(Constants.sH_812 ? Constants.sW * 0.8 : Constants.sW * 0.6)
        })
        buyOneMonthButton.heightAnchor.constraint(equalToConstant: Constants.sH / 9).isActive = true
        vForButtonsStackView.addArrangedSubview(buyOneMonthButton)
        vForButtonsStackView.addArrangedSubview(buyThreeMonthButton)
        view.add(vForButtonsStackView, layoutBlock: {
            $0.bottom(Constants.sH_812 ? 80 : 50).leading(16).trailing(16)
        })
        view.add(getPremiumLabel, layoutBlock: {
            $0.bottomTop(Constants.sH_812 ? -50 : -25, to: vForButtonsStackView).leading(16).trailing(16)
        })
        vOneMonthStackView.addArrangedSubview(oneMonthLabel)
        vOneMonthStackView.addArrangedSubview(priceOneMonthLabel)
        vThreeMonthStackView.addArrangedSubview(threeMonthLabel)
        vThreeMonthStackView.addArrangedSubview(priceThreeMonthLabel)
        buyOneMonthButton.add(vOneMonthStackView, layoutBlock: { $0.center() })
        buyThreeMonthButton.add(vThreeMonthStackView, layoutBlock: { $0.center() })
        buyThreeMonthButton.add(fullProgramImage, layoutBlock: { $0.leading(5).centerY() })
    }
}

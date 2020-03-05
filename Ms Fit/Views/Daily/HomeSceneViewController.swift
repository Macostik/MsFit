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
import FSPagerView

class HomeSceneViewController: BaseViewController<HomeSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let pagerView = FSPagerView()
    private let pageControl = specify(FSPageControl(), {
        $0.contentHorizontalAlignment = .center
    })
    
    private let fullProgramImage = specify(UIImageView(), {
        $0.image = #imageLiteral(resourceName: "buy_three_month_icon")
    })
    
    private let backfullProgramImage = specify(UIImageView(), {
        $0.image = #imageLiteral(resourceName: "daily_back_buy_three_month_icon")
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
        $0.isUserInteractionEnabled = true
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
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.bounces = true
        pagerView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        pageControl.interitemSpacing = 10
        pageControl.numberOfPages = HomeImageList.allCases.count
        pageControl.setFillColor(UIColor.systemBackground.withAlphaComponent(0.3), for: .normal)
        pageControl.setFillColor(UIColor.systemBackground, for: .selected)
        pageControl.setPath(.init(ovalIn: .init(x: -1, y: -1.5, width: 10, height: 10)), for: .selected)
        pageControl.setPath(.init(ovalIn: .init(x: 0, y: 0, width: 7, height: 7)), for: .normal)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).leading(4).size(44)
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
        buyThreeMonthButton.add(fullProgramImage, layoutBlock: {
            $0.leading(5).centerY().height(Constants.sH_812 ? 105 : Constants.sH_667 ? 84 : 64)
        })
        view.sendSubviewToBack(backfullProgramImage, layoutBlock: {
            $0.trailing(-5, to: fullProgramImage).centerY(to: fullProgramImage)
                .height(Constants.sH_812 ? 105 : Constants.sH_667 ? 84 : 64)
        })
        bgDayliCircleImage.add(pagerView, layoutBlock: { $0.edges() })
        pagerView.add(pageControl, layoutBlock: { $0.bottom(Constants.sH_812 ? 40 : 10).centerX() })
    }
}

extension HomeSceneViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return HomeImageList.allCases.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier,
                                                 at: index) as! HomeCell
        let entry = HomeImageList.allCases[index]
        cell.setup(entry: entry)
        return cell
    }
}

extension HomeSceneViewController: FSPagerViewDelegate {
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }
}

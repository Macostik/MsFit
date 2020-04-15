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
    
    private let message = """
    اشتراكك العام في العضوية صالح حتى 23.04.2020. مع الدفع الجديد سيكون اشتراكك
    تطول من التاريخ المذكور
    """
    
    private let pagerView = FSPagerView()
    private let pageControl = specify(FSPageControl(), {
        $0.contentHorizontalAlignment = .center
    })
    
    private let fullProgramImage = specify(UIImageView(), {
        $0.image = UIImage(named: "fullProgramm_icon")
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.3607843137, blue: 0.9098039216, alpha: 1)
    })
    
    private let bgDayliCircleImage = specify(UIImageView(image: #imageLiteral(resourceName: "dailyCircle")), {
        $0.layer.shadowColor = #colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: 5)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.5
        $0.isUserInteractionEnabled = true
    })
    
    private let oneMonthLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textAlignment = .center
        $0.text = "3 اشهر"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let threeMonthLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textAlignment = .center
        $0.text = "الممتازة"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let priceOneMonthLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
        $0.text = "21.99 USD"
        $0.textColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    private let priceThreeMonthLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
        $0.text = "46.99 USD"
        $0.textColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
    })
    
    private let getPremiumLabel = specify(UILabel(), {
        $0.text = "عرض خاص بمناسبة الإطلاق"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 20 : 17, weight: .regular)
        $0.textAlignment = .center
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
        buyOneMonthButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.createAlertController()
            }).disposed(by: disposeBag)
        
        buyThreeMonthButton.animateWhenPressed(disposeBag: disposeBag)
        buyThreeMonthButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.createAlertController()
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.9800000191, blue: 0.9800000191, alpha: 1)
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.bounces = true
        pagerView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        pagerView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        pageControl.interitemSpacing = 10
        pageControl.numberOfPages = HomeImageList.allCases.count
        pageControl.setFillColor(UIColor.systemBackground.withAlphaComponent(0.3), for: .normal)
        pageControl.setFillColor(UIColor.systemBackground, for: .selected)
        pageControl.setPath(.init(ovalIn: .init(x: -1, y: -1.5, width: 10, height: 10)), for: .selected)
        pageControl.setPath(.init(ovalIn: .init(x: 0, y: 0, width: 7, height: 7)), for: .normal)
    }
    
    fileprivate func addConstraints() {
        buyOneMonthButton.heightAnchor.constraint(equalToConstant: Constants.sW * 0.25).isActive = true
        
        let vForButtonsStackView = VStackView(arrangedSubviews: [buyOneMonthButton, buyThreeMonthButton],
                                              spacing: Constants.sH_812 ? 30 : 20)
        vForButtonsStackView.distribution = .fillEqually
        
        let vOneMonthStackView = VStackView(arrangedSubviews: [oneMonthLabel, priceOneMonthLabel])
        vOneMonthStackView.isUserInteractionEnabled = false
        let vThreeMonthStackView = VStackView(arrangedSubviews: [threeMonthLabel, priceThreeMonthLabel])
        vThreeMonthStackView.isUserInteractionEnabled = false
        
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).leading(4).size(44)
        })
        view.add(bgDayliCircleImage, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing()
                .height(Constants.sH_812 ? Constants.sW * 0.8 : Constants.sW * 0.7)
        })
        view.add(vForButtonsStackView, layoutBlock: {
            $0.bottom(Constants.sH_812 ? 80 : 30).leading(16).trailing(16)
        })
        view.add(getPremiumLabel, layoutBlock: {
            $0.bottomTop(Constants.sW * -0.1, to: vForButtonsStackView).leading(16).trailing(16)
        })
        
        buyOneMonthButton.add(vOneMonthStackView, layoutBlock: { $0.center() })
        buyThreeMonthButton.add(vThreeMonthStackView, layoutBlock: { $0.center() })
        buyThreeMonthButton.add(fullProgramImage, layoutBlock: {
            $0.trailing(5).top(-6).bottom(-10).width(Constants.sW * 0.3)
        })
        bgDayliCircleImage.add(pagerView, layoutBlock: { $0.edges() })
        pagerView.add(pageControl, layoutBlock: { $0.bottom(Constants.sH_667 ? 40 : 10).centerX() })
    }
    
    private func createAlertController() {
        let alertController = UIAlertController(title: "هل تريد شراء Premium؟",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "حسنا", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
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

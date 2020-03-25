//
//  BreakfastCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import FSPagerView
import RxSwift
import RxCocoa

class BreakfastCell: UICollectionViewCell, FSPagerViewDataSource, CellIdentifierable {
    
    private let pagerView = FSPagerView()
    public var tapHalper: (() -> Void)?
    
    private let iconImageView = specify(UIImageView(), {
        $0.image = UIImage(named: "Breakfast")
        $0.contentMode = .scaleAspectFit
    })
    
    private let breakfastLabel = specify(UILabel(), {
        $0.text = "Breakfast"
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    })
    
    public func setup(_ entry: Int) {
        setupUI()
        addConstraint()
    }
    
    fileprivate func setupUI() {
        pagerView.transformer = PagerViewTransformer(type: .coverFlow)
        pagerView.register(BreakfastPagerCell.self, forCellWithReuseIdentifier: BreakfastPagerCell.identifier)
        pagerView.backgroundColor = .systemBackground
        pagerView.itemSize = CGSize(width: Constants.sW - 120, height: Constants.sH * 0.47)
        pagerView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        pagerView.dataSource = self
        pagerView.isInfinite = true
        pagerView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    fileprivate func addConstraint() {
        iconImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        let hStackView = HStackView(arrangedSubviews: [iconImageView, breakfastLabel], spacing: 10)
        
        add(hStackView, layoutBlock: { $0.top().centerX(-10) })
        add(pagerView, layoutBlock: { $0.topBottom(to: hStackView).leading().bottom().trailing() })
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return BreakfastList.allCases.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: BreakfastPagerCell.identifier,
                                                 at: index) as! BreakfastPagerCell
        let entry = BreakfastList.allCases[index]
        cell.setup(entry: entry)
        cell.tapHalper = tapHalper
        return cell
    }
}

class BreakfastPagerCell: FSPagerViewCell, CellIdentifierable {
    
    fileprivate let disposeBag = DisposeBag()
    public var tapHalper: (() -> Void)?
    
    private let breakfastImageView = specify(UIImageView(), {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
    private lazy var heartImageView = specify(UIImageView(), {
        $0.image = UIImage(systemName: "heart", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
    })
    
    private let subheadingLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let caloriesLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6666666667, alpha: 1)
    })
    
    public let addItemsButton = specify(UIButton(type: .roundedRect), {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
        $0.setTitleColor(#colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), for: .normal)
        $0.customButton(text: "Add", font: 13, weight: .medium, shadowColor: .clear, isCircled: true)
    })
    
    private let containerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.layer.shadowRadius = 10
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowOffset = .init(width: 0, height: 5)
        $0.clipsToBounds = false
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    })
    
    public func setup(entry: BreakfastList) {
        breakfastImageView.image = UIImage(named: entry.rawValue)
        subheadingLabel.text = entry.description().0
        caloriesLabel.text = entry.description().1
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .clear
    }
    
    func setupBindings() {
        addItemsButton.rx.tap
            .subscribe(onNext: {
                self.tapHalper?()
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        heartImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        heartImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        add(breakfastImageView, layoutBlock: { $0.leading().trailing().top() })
        breakfastImageView.add(heartImageView, layoutBlock: { $0.leading(16).top(16) })
        add(containerView, layoutBlock: { $0.bottom().leading().trailing().topBottom(to: breakfastImageView)})
        containerView.add(subheadingLabel, layoutBlock: {
            $0.leading(16).trailing(16).top(Constants.sH_667 ? 30 : 15)
        })
        containerView.add(caloriesLabel, layoutBlock: {
            $0.leading(16).topBottom(25, to: subheadingLabel).trailing(16).bottom(Constants.sH_667 ? 40 : 20)
        })
        containerView.add(addItemsButton, layoutBlock: {
            $0.trailing(16).centerY(to: caloriesLabel).width(50).height(30)
        })
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
}

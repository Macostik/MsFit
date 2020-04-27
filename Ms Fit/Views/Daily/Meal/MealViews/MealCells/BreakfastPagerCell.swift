//
//  BreakfastPagerCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 01.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import FSPagerView
import RxCocoa
import RxSwift

class BreakfastPagerCell: FSPagerViewCell, CellIdentifierable {
    
    fileprivate let disposeBag = DisposeBag()
    public var tapHalper: (() -> Void)?
    private var isLikeFood = false
    
    private let breakfastImageView = specify(UIImageView(), {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    })
    
    private let heartConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var likeButton = specify(Button(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "suit.heart.fill", withConfiguration: heartConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
        $0.touchArea.width = 45
        $0.touchArea.height = 45
    })
    
    private let gradientView = specify(GradientView(), {
        $0.topColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.4)
        $0.bottomColor = .clear
        $0.startPointX = 1
        $0.startPointY = 0.1
        $0.endPointX = 1
        $0.endPointY = 1
        $0.cornerRad = 5
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
        $0.customButton(text: "أضف", font: 13, weight: .medium, shadowColor: .clear, isCircled: true)
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
        
        likeButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.likeButton.setImage(self.isLikeFood ? UIImage(systemName: "suit.heart.fill")?
                    .withTintColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), renderingMode: .alwaysOriginal) :
                    UIImage(systemName: "suit.heart", withConfiguration: self.heartConfiguration)?
                        .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
                self.isLikeFood.toggle()
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        add(breakfastImageView, layoutBlock: { $0.leading().trailing().top() })
        add(gradientView, layoutBlock: { $0.top().leading().trailing().height(Constants.sW * 0.15) })
        add(likeButton, layoutBlock: { $0.leading(16).top(16) })
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

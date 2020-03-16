//
//  SlideSegmentControl.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 27.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SlideSegmentControl: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    private let menuItems = ["Meals", "Exercises", "Subscriptions"]
    private let slideItems = [MealsView(), ExerciseView(), SubscriptionView()]
    
    private var slideView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
    })
    
    private var separatorView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.layer.shadowColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.layer.shadowRadius = 3
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = CGSize(width: 0, height: 3)
    })
    
    private lazy var menuCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let size = Constants.sW/CGFloat(self.menuItems.count)
        layout.itemSize = CGSize(width: size, height: 45)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        collectionView.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        return collectionView
    }()
    
    private let slideCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let navHeight: CGFloat = 100
        let menuHeight: CGFloat = 55
        layout.itemSize = CGSize(width: Constants.sW, height: Constants.sH - navHeight - menuHeight)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(SlideCell.self, forCellWithReuseIdentifier: SlideCell.identifier)
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        handleUI()
        addConstraints()
    }
    
    fileprivate func handleUI() {
        Observable.just(menuItems)
            .bind(to: menuCollection.rx
                .items(cellIdentifier: MenuCell.identifier, cellType: MenuCell.self)) { _, model, cell in
                    cell.setup(model)
        }.disposed(by: disposeBag)
        
        Observable.just(slideItems)
            .bind(to: slideCollection.rx
                .items(cellIdentifier: SlideCell.identifier, cellType: SlideCell.self)) { _, model, cell in
                    cell.setup(model)
        }.disposed(by: disposeBag)
        
        menuCollection.rx.itemSelected
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                let offset = self.slideCollection.contentSize.width/CGFloat(self.menuItems.count) *
                    CGFloat(index.row)
                self.slideCollection.setContentOffset(offset^0, animated: true)
            }).disposed(by: disposeBag)
        
        menuCollection.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.menuCollection.selectItem(at: indexPath, animated: true,
                                                scrollPosition: .centeredHorizontally)
            }).disposed(by: disposeBag)
        
        slideCollection.rx.contentOffset
            .subscribe(onNext: { [weak self] offset in
                guard let self = self else { return }
                let offsetX = offset.x/CGFloat(self.menuItems.count)
                self.slideView.transform = CGAffineTransform(translationX: offsetX, y: 0)
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        add(menuCollection, layoutBlock: { $0.top().leading().trailing().height(45) })
        add(slideCollection, layoutBlock: { $0.bottom().leading().trailing().topBottom(to: menuCollection) })
        add(separatorView, layoutBlock: { $0.topBottom(to: menuCollection).leading().trailing().height(10) })
        separatorView.add(slideView, layoutBlock: { $0.width(Constants.sW / 3).height(5).leading().bottom() })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

class MenuCell: UICollectionViewCell, CellIdentifierable {
    
    public let titleLabel = specify(Label()) {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .systemBackground
    }
    
    public func setup(_ entry: String) {
        titleLabel.text = entry
        add(titleLabel, layoutBlock: { $0.center() })
    }
}

class SlideCell: UICollectionViewCell, CellIdentifierable {
    
    public func setup(_ entry: UIView) {
        add(entry, layoutBlock: { $0.edges() })
    }
}

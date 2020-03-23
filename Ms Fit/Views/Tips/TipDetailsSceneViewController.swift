//  
//  TipDetailsSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 23.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TipDetailsSceneViewController: BaseViewController<TipDetailsSceneViewModel> {
    
    private let tipDetailView = TipDetailsView()
    private let navigationView = UIView()
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let scrollView = specify(UIScrollView(), {
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
    })
    
    private let tipsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let size = Constants.sW
        layout.itemSize = CGSize(width: size, height: size)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TipsCell.self, forCellWithReuseIdentifier: TipsCell.identifier)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        return collectionView
    }()
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
        
        Observable.just(TipsModel.allCases)
            .bind(to: tipsCollectionView.rx.items(cellIdentifier: TipsCell.identifier, cellType:
                TipsCell.self)) { _, model, cell in
                    cell.setup(model)
        }.disposed(by: disposeBag)
        
        scrollView.rx.contentOffset
            .subscribe(onNext: { [unowned self] offset in
                self.scrollView.contentOffset.y = offset.y < 0.0 ? 0.0 : self.scrollView.contentOffset.y
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationView.setGradientView(topColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bottomColor: .clear, locations: [0.0, 1.0])
    }
    
    fileprivate func addConstraints() {
        view.add(scrollView, layoutBlock: { $0.top().bottom().width(Constants.sW) })
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).leading(4).size(44)
        })
        scrollView.add(tipDetailView, layoutBlock: { $0.top().width(Constants.sW) })
        scrollView.add(tipsCollectionView, layoutBlock: {
            $0.topBottom(40, to: tipDetailView).width(Constants.sW).bottom(20).height(400)
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

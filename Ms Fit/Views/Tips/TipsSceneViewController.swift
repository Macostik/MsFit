//  
//  TipsSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TipsSceneViewController: BaseViewController<TipsSceneViewModel> {
    
    private let tipsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let size = Constants.sW
        layout.itemSize = CGSize(width: size, height: size)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TipsCell.self, forCellWithReuseIdentifier: TipsCell.identifier)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        collectionView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        return collectionView
    }()
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "Tips"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let allCatigoriesButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.setImage(#imageLiteral(resourceName: "navigation_ArrowDown"), for: .normal)
        $0.customButton(text: "All catigories", font: 13, weight: .regular, shadowColor: .clear)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        
        Observable.just(TipsModel.allCases).bind(to: tipsCollectionView.rx
            .items(cellIdentifier: TipsCell.identifier,
                   cellType: TipsCell.self)) { _, model, cell in
                    cell.setup(model)
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    fileprivate func addConstraints() {
        let vNavButtonsStackView = VStackView(arrangedSubviews: [navTextLabel, allCatigoriesButton])
        
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(vNavButtonsStackView, layoutBlock: { $0.centerX().bottom(6) })
        view.add(tipsCollectionView, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing().bottom(tabBarHeight)
        })
    }
}

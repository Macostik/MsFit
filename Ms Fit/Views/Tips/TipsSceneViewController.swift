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
    
    private let tipsMenuView = TipsMenuView()
    
    private var isShowMenu = false
    
    private let tipsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let size = Constants.sW
        layout.itemSize = CGSize(width: size, height: 340)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TipsCell.self, forCellWithReuseIdentifier: TipsCell.identifier)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "نصائح"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let allCatigoriesButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.setImage(#imageLiteral(resourceName: "navigation_ArrowDown"), for: .normal)
        $0.customButton(text: "كل المقالات", font: 13, weight: .regular, shadowColor: .clear)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        Observable.just(TipsModel.allCases)
            .bind(to: tipsCollectionView.rx.items(cellIdentifier: TipsCell.identifier, cellType:
                TipsCell.self)) { _, model, cell in
                    cell.setup(model)
        }.disposed(by: disposeBag)
        
        Observable
            .zip(tipsCollectionView.rx.itemSelected, tipsCollectionView.rx.modelSelected(TipsModel.self))
            .bind { indexPath, model in
                self.viewModel?.presentDetailsObserver.onNext((indexPath.row, model.rawValue))
        }.disposed(by: disposeBag)
        
        allCatigoriesButton.rx.tap
        .subscribe(onNext: { [unowned self] _ in
            if self.isShowMenu {
                UIView.animate(withDuration: 0.3, animations: {
                    self.tipsMenuView.heightConstraints.constant = 0
                    self.tipsMenuView.layoutIfNeeded()
                }, completion: { _ in
                    self.tipsMenuView.isHidden = true
                })
            } else {
                self.tipsMenuView.isHidden = false
                UIView.animate(withDuration: 0.3, animations: {
                    self.tipsMenuView.heightConstraints.constant = Constants.sW * 0.9
                    self.tipsMenuView.layoutIfNeeded()
                })
            }
            self.tipsMenuView.heightConstraints.isActive = self.tipsMenuView.heightConstraints.isActive
            self.isShowMenu.toggle()
        }).disposed(by: disposeBag)
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
        rootViewController?.add(tipsMenuView, layoutBlock: {
            $0.top(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70).leading().trailing().bottom()
        })
        tipsMenuView.isHidden = true
    }
}

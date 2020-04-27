//  
//  LikeMealsSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 02.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

typealias LikeMealsDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Int>>

class LikeMealsSceneViewController: BaseViewController<LikeMealsSceneViewModel> {
    
    private let caloriesView = CaloriesView()
    private let addPopupView = AddPopupView()
    fileprivate let mealList = SectionModel(model: "", items: Array(0...4))
    
    private var isAnimationCalories = false
    private var heightCaloriesLayout: NSLayoutConstraint?
    
    private let navigationView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1) })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.right", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let navLikeLabel = specify(UILabel(), {
        $0.text = "مثل الوجبات"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: Constants.sW, height: Constants.sH * 0.6)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        collectionView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(BreakfastCell.self, forCellWithReuseIdentifier: BreakfastCell.identifier)
        return collectionView
    }()
    
    private let myMealsButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "my_meal_image.pdf"), for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(shadowColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), bgColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    })
    
    private lazy var dataSource: MealsDataSource = {
        return MealsDataSource(configureCell: {  _, collectionView, indexPath, data in
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: BreakfastCell.identifier,
                                     for: indexPath) as? BreakfastCell else { fatalError() }
            cell.setup(data)
            cell.tapHalper = { [unowned self] in
                self.handlePopupView()
            }
            cell.cellTapHalper = { [weak self] index in
                self?.viewModel?.presentMealDetailObserver.onNext((index))
            }
            return cell
        })
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
        
        myMealsButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel?.presentMealsStoregeObserver.onNext(())
            }).disposed(by: disposeBag)
        
        caloriesView.chevronDownButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.heightCaloriesLayout?.isActive = false
                UIView.animate(withDuration: 0.3) {
                    self.heightCaloriesLayout?.constant = self.isAnimationCalories ? 80 : 140
                    self.heightCaloriesLayout?.isActive = true
                    self.caloriesView.chevronDownButton.transform = self.isAnimationCalories ?
                        CGAffineTransform.identity : CGAffineTransform(rotationAngle: -.pi)
                    self.view.layoutIfNeeded()
                }
                self.isAnimationCalories.toggle()
            }).disposed(by: disposeBag)
        
         Observable.just([mealList])
                   .bind(to: collectionView.rx.items(dataSource: dataSource))
                   .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        addPopupView.isHidden = true
        caloriesView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    fileprivate func addConstraints() {
        heightCaloriesLayout = caloriesView.heightAnchor.constraint(equalToConstant: 80)
        heightCaloriesLayout?.isActive = true
        
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navLikeLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 8) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navLikeLabel).leading(4).size(44) })
        view.add(caloriesView, layoutBlock: { $0.topBottom(to: navigationView).leading().trailing() })
        view.add(collectionView, layoutBlock: { $0.topBottom(to: caloriesView).leading().trailing().bottom()})
        view.add(myMealsButton, layoutBlock: {
            $0.bottom(Constants.sH_812 ? 25 : 15).trailing(Constants.sH_812 ? 25 : 15).size(56)
        })
        view.add(addPopupView, layoutBlock: { $0.edges() })
    }
    
    fileprivate func handlePopupView() {
        addPopupView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.addPopupView.containerView.transform = .identity
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

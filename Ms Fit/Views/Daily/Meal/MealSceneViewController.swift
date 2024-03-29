//  
//  MealSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

typealias MealsDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Int>>

class MealSceneViewController: BaseViewController<MealSceneViewModel> {
    
    private let caloriesView = CaloriesView()
    private let addPopupView = AddPopupView()
    fileprivate let mealList = SectionModel(model: "", items: Array(0...4))
    
    private var isCheckmarkItem = false
    private var isAnimationCalories = false
    private var heightCaloriesLayout: NSLayoutConstraint?
    private var isAppearHeader = false
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.right", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1)
    })
    
    private let navQuestionsLabel = specify(UILabel(), {
        $0.text = "وجباتي"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let myMealsButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "my_meal_image.pdf"), for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(shadowColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), bgColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    })
    
    private let countMealsLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 10, weight: .bold)
        $0.backgroundColor = .systemBackground
        $0.text = "4"
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.textAlignment = .center
        $0.textColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
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
        }, configureSupplementaryView: { _, collectionview, kind, indexPath  in
            guard let headerView = collectionview
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: MealHeaderView.identifier,
                                                  for: indexPath) as? MealHeaderView else { fatalError() }
            if !self.isAppearHeader {
                self.isAppearHeader = true
                headerView.setup()
                headerView.tapPresentSearchHanper = { [weak self] in
                    self?.viewModel?.presentSearchObserver.onNext(())
                }
                headerView.tapPresentLikeMealsHanper = { [weak self] in
                    self?.viewModel?.presentLikeMealsObserver.onNext(())
                }
                headerView.tapHighProteinHanper = { [weak self] checkMarkView in
                    guard let self = self else { return }
                    checkMarkView.alpha = self.isCheckmarkItem ? 0.0 : 1.0
                    self.isCheckmarkItem.toggle()
                }
            }
            return headerView
        })
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: Constants.sW, height: Constants.sH * 0.6)
        layout.headerReferenceSize = CGSize(width: Constants.sW, height: 130)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(BreakfastCell.self, forCellWithReuseIdentifier: BreakfastCell.identifier)
        collectionView.register(MealHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MealHeaderView.identifier)
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
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        addPopupView.isHidden = true
        caloriesView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    fileprivate func addConstraints() {
        heightCaloriesLayout = caloriesView.heightAnchor.constraint(equalToConstant: 80)
        heightCaloriesLayout?.isActive = true
        
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navQuestionsLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navQuestionsLabel).leading(4).size(44)})
        view.add(caloriesView, layoutBlock: { $0.topBottom(to: navigationView).leading().trailing() })
        view.add(collectionView, layoutBlock: { $0.topBottom(to: caloriesView).leading().trailing().bottom()})
        view.add(myMealsButton, layoutBlock: {
            $0.bottom(Constants.sH_812 ? 25 : 15).trailing(Constants.sH_812 ? 25 : 15).size(56)
        })
        view.add(addPopupView, layoutBlock: { $0.edges() })
        myMealsButton.add(countMealsLabel, layoutBlock: { $0.top(1).trailing(1).size(16) })
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

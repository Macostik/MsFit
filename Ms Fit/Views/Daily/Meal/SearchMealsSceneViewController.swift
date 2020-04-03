//  
//  SearchMealsSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 13.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchMealsSceneViewController: BaseViewController<SearchMealsSceneViewModel> {
    
    private let addFoodPopupView = AddPopupView()
    
    private var isCheckmarkItem = false
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let searchBar = specify(UISearchBar(), {
        $0.placeholder = "Search for products"
        $0.searchBarStyle = .minimal
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1)
    })
    
    private let navSearchLabel = specify(UILabel(), {
        $0.text = "Search meals"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let myMealsButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "my_meal_image.pdf"), for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(shadowColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), bgColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1))
    })
    
    private let checkmarkView = specify(UIView(), {
        let image = UIImageView(image: UIImage(named: "chackmark_icon"))
        $0.backgroundColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1).withAlphaComponent(0.8)
        $0.layer.cornerRadius = (Constants.sW / 6.5) / 2
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
        $0.alpha = 0
        $0.add(image, layoutBlock: { $0.center().width(19).height(14) })
    })
    
    private let fruitLabel = specify(UILabel(), {
        $0.text = "Fruit"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    private let fruitImageView = specify(UIImageView(), { $0.image = #imageLiteral(resourceName: "grape_icon") })
    private let fruitView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = (Constants.sW / 6.5) / 2
        $0.layer.shadowColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: -0.3)
        $0.layer.shadowOpacity = 0.3
    })
    
    private let drinkLabel = specify(UILabel(), {
        $0.text = "Drink"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let drinkImageView = specify(UIImageView(), { $0.image = #imageLiteral(resourceName: "smoothie_icon") })
    private let drinkView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = (Constants.sW / 6.5) / 2
        $0.layer.shadowColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: -0.3)
        $0.layer.shadowOpacity = 0.3
    })
    
    private let saucesLabel = specify(UILabel(), {
        $0.text = "Sauces"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let saucesImageView = specify(UIImageView(), { $0.image = #imageLiteral(resourceName: "ketchup_icon") })
    private let saucesView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = (Constants.sW / 6.5) / 2
        $0.layer.shadowColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: -0.3)
        $0.layer.shadowOpacity = 0.3
    })
    
    private let snackLabel = specify(UILabel(), {
        $0.text = "Snacks"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let snackImageView = specify(UIImageView(), { $0.image = #imageLiteral(resourceName: "snack_icon") })
    private let snackView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = (Constants.sW / 6.5) / 2
        $0.layer.shadowColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.layer.shadowOffset = .init(width: 0, height: -0.3)
        $0.layer.shadowOpacity = 0.3
    })
    
    private let tableView = specify(UITableView(frame: .zero, style: .grouped), {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.contentInset = .init(top: 0, left: 0, bottom: 25, right: 0)
        $0.register(SearchFoodsCell.self, forCellReuseIdentifier: SearchFoodsCell.identifier)
    })
    
    override func setupUI() {
        handleUI()
        addConstraint()
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
        
        fruitView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [unowned self] _ in
                self.checkmarkView.alpha = self.isCheckmarkItem ? 0.0 : 1.0
                self.isCheckmarkItem = !self.isCheckmarkItem
            }).disposed(by: disposeBag)
        
        drinkView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
        
        saucesView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
            
            }).disposed(by: disposeBag)
        
        snackView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
        
        Observable.just(AddFoodsModel.allCases)
            .bind(to: tableView.rx.items(cellIdentifier: SearchFoodsCell.identifier,
                                         cellType: SearchFoodsCell.self)) { _, model, cell in
                                            cell.setup(model)
                                            cell.tapHalper = { [unowned self] in
                                                self.handlePopupView()
                                            }
        }.disposed(by: disposeBag)
        
        Observable
        .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(AddFoodsModel.self))
        .bind { indexPath, model in
            self.viewModel?.presentDetailFoodObserver.onNext((indexPath.row, model.rawValue))
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        addFoodPopupView.isHidden = true
    }
    
    fileprivate func addConstraint() {
        fruitView.heightAnchor.constraint(equalToConstant: Constants.sW / 6.5).isActive = true
        fruitView.widthAnchor.constraint(equalToConstant: Constants.sW / 6.5).isActive = true
        
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        view.add(searchBar, layoutBlock: { $0.topBottom(10, to: navigationView).leading(10).trailing(10) })
        navigationView.add(navSearchLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navSearchLabel).leading(4).size(44) })
        
        let hStackViewForButtons = HStackView(arrangedSubviews: [
            VStackView(arrangedSubviews: [fruitView, fruitLabel], spacing: 5),
            VStackView(arrangedSubviews: [drinkView, drinkLabel], spacing: 5),
            VStackView(arrangedSubviews: [saucesView, saucesLabel], spacing: 5),
            VStackView(arrangedSubviews: [snackView, snackLabel], spacing: 5)
        ], spacing: 25)
        hStackViewForButtons.distribution = .fillEqually
        hStackViewForButtons.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        fruitView.add(fruitImageView, layoutBlock: { $0.edges(10) })
        fruitView.add(checkmarkView, layoutBlock: { $0.edges() })
        drinkView.add(drinkImageView, layoutBlock: { $0.edges(10) })
        saucesView.add(saucesImageView, layoutBlock: { $0.edges(10) })
        snackView.add(snackImageView, layoutBlock: { $0.edges(10) })
        
        view.add(hStackViewForButtons, layoutBlock: {
            $0.topBottom(Constants.sH_812 ? 25 : 10, to: searchBar).centerX()
        })
        view.add(tableView, layoutBlock: {
            $0.topBottom(16, to: hStackViewForButtons).leading().trailing().bottom()
        })
        view.add(myMealsButton, layoutBlock: {
            $0.bottom(Constants.sH_812 ? 25 : 15).trailing(Constants.sH_812 ? 25 : 15).size(56)
        })
        view.add(addFoodPopupView, layoutBlock: { $0.edges() })
    }
    
    fileprivate func handlePopupView() {
        addFoodPopupView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.addFoodPopupView.containerView.transform = .identity
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension SearchMealsSceneViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "Results Found 234"
        titleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        titleLabel.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        view.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1)
        view.add(titleLabel, layoutBlock: { $0.leading(16).bottom(5) })
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 0
    }
}

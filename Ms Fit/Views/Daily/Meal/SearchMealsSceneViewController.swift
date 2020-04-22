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
        $0.setImage(UIImage(systemName: "chevron.right", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    internal lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let width = Constants.sW * 0.17
        layout.sectionInset = UIEdgeInsets(top: 0, left: width * 0.7, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: width + 11)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.isScrollEnabled = false
        collectionView.register(SearchHeaderCell.self,
                                forCellWithReuseIdentifier: SearchHeaderCell.identifier)
        return collectionView
    }()
    
    private let searchBar = specify(UISearchBar(), {
        $0.semanticContentAttribute = .forceRightToLeft
        $0.searchTextField.textAlignment = .right
        $0.searchTextField.layer.cornerRadius = 36/2
        $0.searchTextField.clipsToBounds = true
        $0.placeholder = "بحث"
        $0.searchBarStyle = .minimal
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1)
    })
    
    private let navSearchLabel = specify(UILabel(), {
        $0.text = "ابحث عن وجبات الطعام"
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
    
    private let checkmarkView = specify(UIView(), {
        let image = UIImageView(image: UIImage(named: "chackmark_icon"))
        $0.backgroundColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1).withAlphaComponent(0.8)
        $0.layer.cornerRadius = (Constants.sW / 6.5) / 2
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
        $0.alpha = 0
        $0.add(image, layoutBlock: { $0.center().width(19).height(14) })
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
        
        Observable.just(HeaderModel.allCases)
            .bind(to: collectionView.rx.items(cellIdentifier: SearchHeaderCell.identifier,
                                              cellType: SearchHeaderCell.self)) { _, model, cell in
                                                cell.setup(with: model)
        }.disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [unowned self] _ in
                self.searchBar.searchTextField.resignFirstResponder()
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        addFoodPopupView.isHidden = true
    }
    
    fileprivate func addConstraint() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        view.add(searchBar, layoutBlock: { $0.topBottom(10, to: navigationView).leading(10).trailing(10) })
        navigationView.add(navSearchLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 8) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navSearchLabel).leading(4).size(44) })
        view.add(collectionView, layoutBlock: { $0.topBottom(to: searchBar).leading().trailing().height(100)})
        view.add(tableView, layoutBlock: { $0.topBottom(to: collectionView).leading().trailing().bottom() })
        view.add(myMealsButton, layoutBlock: {
            $0.bottom(Constants.sH_812 ? 25 : 15).trailing(Constants.sH_812 ? 25 : 15).size(56)
        })
        view.add(addFoodPopupView, layoutBlock: { $0.edges() })
        myMealsButton.add(countMealsLabel, layoutBlock: { $0.top(1).trailing(1).size(16) })
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
        titleLabel.text = "تم العثور على 234"
        titleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        view.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1)
        view.add(titleLabel, layoutBlock: { $0.leading(16).bottom(5) })
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 0
    }
}

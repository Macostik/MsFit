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
    
    private let tipsModel = [
        TipModels(image: "food1", text: "Chicken breast with rice and boiled vegetables"),
        TipModels(image: "food2", text: "Chicken breast with rice and boiled vegetables"),
        TipModels(image: "food3", text: "Chicken breast with rice and boiled vegetables"),
        TipModels(image: "food4", text: "Chicken breast with rice and boiled vegetables"),
        TipModels(image: "food5", text: "Chicken breast with rice and boiled vegetables"),
        TipModels(image: "food6", text: "Chicken breast with rice and boiled vegetables"),
        TipModels(image: "food7", text: "Chicken breast with rice and boiled vegetables"),
        TipModels(image: "food8", text: "Chicken breast with rice and boiled vegetables")
    ]
    
    private var collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    
    private let vNavButtonsStackView = specify(UIStackView(), {
        $0.axis = .vertical
    })
    
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
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        
        addCollectionView()
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        vNavButtonsStackView.addArrangedSubview(navTextLabel)
        vNavButtonsStackView.addArrangedSubview(allCatigoriesButton)
        navigationView.add(vNavButtonsStackView, layoutBlock: { $0.centerX().bottom(6) })
        view.add(collectionView, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing().bottom(tabBarHeight)
        })
    }
    
    fileprivate func addCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9764705882, alpha: 1)
        collectionView.register(TipsCell.self, forCellWithReuseIdentifier: TipsCell.reuseId)
    }
}

extension TipsSceneViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tipsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipsCell.reuseId,
                                                      for: indexPath) as! TipsCell
        let tip = tipsModel[indexPath.row]
        cell.setup(tip: tip)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: Constants.sW, height: Constants.sW * 0.9)
    }
}

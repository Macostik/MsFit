//
//  BaseAllVideoViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class BaseAllVideoViewController: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    internal lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let size = Constants.sW
        layout.itemSize = CGSize(width: size, height: size * 0.7)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AllVideoCell.self, forCellWithReuseIdentifier: AllVideoCell.identifier)
        collectionView.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
        collectionView.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.9800000191, blue: 0.9800000191, alpha: 1)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.9800000191, blue: 0.9800000191, alpha: 1)
        handleUI()
        addConstraints()
    }
    
    internal func setupUI() {}
    
    fileprivate func handleUI() {
        Observable.just(ArmWorkoutList.allCases)
            .bind(to: collectionView.rx.items(cellIdentifier: AllVideoCell.identifier, cellType:
                AllVideoCell.self)) { _, model, cell in
                    cell.setup(model)
        }.disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        add(collectionView, layoutBlock: { $0.edges() })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

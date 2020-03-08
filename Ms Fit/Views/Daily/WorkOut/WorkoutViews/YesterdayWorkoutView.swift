//
//  YesterdayWorkoutView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 05.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

typealias YesterdayWorkoutDataSource = RxCollectionViewSectionedReloadDataSource<YesterdayWorkoutSceneModel>

class YesterdayWorkoutView: BaseWorkOutView {
    
    private lazy var dataSource: YesterdayWorkoutDataSource = {
            return YesterdayWorkoutDataSource(configureCell: {  _, collectionView, indexPath, data in
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: YesterdayWorkoutCell.identifier,
                                         for: indexPath) as? YesterdayWorkoutCell else { fatalError() }
                cell.setup(exercise: data)
                return cell
            })
        }()
    
    override func setupUI() {
        collectionView.register(YesterdayWorkoutCell.self,
                                forCellWithReuseIdentifier: YesterdayWorkoutCell.identifier)
        timeLabel.text = "110"
        let section = [YesterdayWorkoutSceneModel(items: YesterdayWorkoutList.allCases)]
        Observable.just(section)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        startWorkoutButton.animateWhenPressed(disposeBag: disposeBag)
        startWorkoutButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
    }
}

//
//  TodayWorkoutView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 05.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

typealias TodayWorkoutDataSource = RxCollectionViewSectionedReloadDataSource<TodayWorkoutSceneModel>

class TodayWorkoutView: BaseWorkOutView {
    
    private lazy var dataSource: TodayWorkoutDataSource = {
        return TodayWorkoutDataSource(configureCell: {  _, collectionView, indexPath, data in
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: TodayWorkoutCell.identifier,
                                     for: indexPath) as? TodayWorkoutCell else { fatalError() }
            cell.setup(exercise: data)
            return cell
        })
    }()

    override func setupUI() {
        collectionView.register(TodayWorkoutCell.self,
                                       forCellWithReuseIdentifier: TodayWorkoutCell.identifier)
        timeLabel.text = "40"
        let section = [TodayWorkoutSceneModel(items: TodayWorkoutList.allCases)]
        Observable.just(section)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        startWorkoutButton.animateWhenPressed(disposeBag: disposeBag)
        startWorkoutButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
        
        Observable
        .zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(TodayWorkoutList.self))
        .bind { indexPath, model in
            self.viewModel?.presentObserver.onNext((indexPath.row, model.rawValue))
        }.disposed(by: disposeBag)
    }
}

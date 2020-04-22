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

class TodayWorkoutView: BaseWorkOutView {
    
    override func setupUI() {
        collectionView.register(TodayWorkoutCell.self,
                                forCellWithReuseIdentifier: TodayWorkoutCell.identifier)
        timeLabel.text = "40"
        let exercises = RealmProvider.shared.realm.objects(ExercisesModel.self)[1].exercises.toArray()
        Observable.just(exercises)
            .bind(to: collectionView.rx.items(cellIdentifier: TodayWorkoutCell.identifier,
                                              cellType: TodayWorkoutCell.self)) { _, model, cell in
                                                cell.setup(exercise: model)
        }.disposed(by: disposeBag)
        
        startWorkoutButton.animateWhenPressed(disposeBag: disposeBag)
        startWorkoutButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
        
        Observable
        .zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(ExerciseItem.self))
        .bind { indexPath, model in
//            self.viewModel?.presentObserver.onNext((indexPath.row, model.rawValue))
        }.disposed(by: disposeBag)
    }
}

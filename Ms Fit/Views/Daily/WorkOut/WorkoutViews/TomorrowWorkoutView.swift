//
//  TomorrowWorkoutView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 05.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class TomorrowWorkoutView: BaseWorkOutView {
 
    override func setupUI() {
        collectionView.register(TomorrowWorkoutCell.self,
        forCellWithReuseIdentifier: TomorrowWorkoutCell.identifier)
        timeLabel.text = "0"
       if let exercises = RealmProvider.shared.realm.objects(ExercisesModel.self)
           .last?.exercises.toArray() {
           Observable.just(exercises)
               .bind(to: collectionView.rx.items(cellIdentifier: TomorrowWorkoutCell.identifier,
               cellType: TomorrowWorkoutCell.self)) { _, model, cell in
                 cell.setup(exercise: model)
           }.disposed(by: disposeBag)
       }
        
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

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

typealias TomorrowWorkoutDataSource = RxCollectionViewSectionedReloadDataSource<TomorrowWorkoutSceneModel>

class TomorrowWorkoutView: BaseWorkOutView {
    
    private lazy var dataSource: TomorrowWorkoutDataSource = {
           return TomorrowWorkoutDataSource(configureCell: {  _, collectionView, indexPath, data in
               guard let cell = collectionView
                   .dequeueReusableCell(withReuseIdentifier: TomorrowWorkoutCell.identifier,
                                        for: indexPath) as? TomorrowWorkoutCell else { fatalError() }
               cell.setup(exercise: data)
               return cell
           })
       }()
 
    override func setupUI() {
        collectionView.register(TomorrowWorkoutCell.self,
        forCellWithReuseIdentifier: TomorrowWorkoutCell.identifier)
        timeLabel.text = "60"
        let section = [TomorrowWorkoutSceneModel(items: TomorrowWorkoutList.allCases)]
        Observable.just(section)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        startWorkoutButton.animateWhenPressed(disposeBag: disposeBag)
        startWorkoutButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
        Observable
        .zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(TomorrowWorkoutList.self))
        .bind { indexPath, model in
            self.viewModel?.presentObserver.onNext((indexPath.row, model.rawValue))
        }.disposed(by: disposeBag)
    }
}

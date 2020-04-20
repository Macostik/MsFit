//
//  ArmView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

typealias ArmDataSource = RxCollectionViewSectionedReloadDataSource<ArmWorkoutSceneModel>

class ArmView: BaseAllVideoViewController {
    
    fileprivate let disposeBag = DisposeBag()
    
    private lazy var dataSource: ArmDataSource = {
        return ArmDataSource(configureCell: {  _, collectionView, indexPath, data in
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: AllVideoCell.identifier,
                                     for: indexPath) as? AllVideoCell else { fatalError() }
            cell.setup(data)
            return cell
            })
        }()
    
    override func setupUI() {
        collectionView.register(AllVideoCell.self,
                                forCellWithReuseIdentifier: AllVideoCell.identifier)
        let section = [ArmWorkoutSceneModel(items: ArmWorkoutList.allCases)]
        
        Observable.just(section)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
//        Observable
//            .zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(ArmWorkoutList.self))
//            .bind { [unowned self] indexPath, model in
//                self.viewModel?.presentObserver.onNext((indexPath.row, model.rawValue))
//        }.disposed(by: disposeBag)
    }
}

enum ArmWorkoutList: String, CaseIterable {
    case arm_rotations, push_ups, crunches, arm_circles, burpees, wall_sit, jumping_jacks, squats
    
    func description() -> String{
        switch self {
        case .arm_rotations:
            return "1. Arm rotations"
        case .push_ups:
            return "2. Push-ups"
        case .crunches:
            return "3. Crunches"
        case .arm_circles:
            return "4. Arm circles"
        case .burpees:
            return "5. Burpees"
        case .wall_sit:
            return "6. Wall Sit"
        case .jumping_jacks:
            return "7. Jumping Jacks"
        case .squats:
            return "8. Squats"
        }
    }
}

struct ArmWorkoutSceneModel {
    var items: [ArmWorkoutList]
}

extension ArmWorkoutSceneModel: SectionModelType {
    typealias Item = ArmWorkoutList
    
    init(original: ArmWorkoutSceneModel, items: [Item]) {
        self = original
        self.items = items
    }
}

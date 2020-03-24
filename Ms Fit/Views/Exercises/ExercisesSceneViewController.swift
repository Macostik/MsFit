//  
//  ExercisesSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

typealias ExercisesDataSource = RxCollectionViewSectionedReloadDataSource<ExercisesSceneModel>

class ExercisesSceneViewController: BaseViewController<ExercisesSceneViewModel> {
    
    private lazy var dataSource: ExercisesDataSource = {
        return ExercisesDataSource(configureCell: {  _, collectionView, indexPath, data in
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ExerciseCell.identifier,
                                     for: indexPath) as? ExerciseCell else { fatalError() }
            cell.setup(exercise: data)
            return cell
        })
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let size = Constants.sW/2 - 15
        layout.itemSize = CGSize(width: size, height: size)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: ExerciseCell.identifier)
        collectionView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        return collectionView
    }()
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "Exercises"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let presentExerciseButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.setTitle("Exercises", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        let section = [ExercisesSceneModel(items: ExercisesList.allCases)]
        Observable.just(section)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        presentExerciseButton.animateWhenPressed(disposeBag: disposeBag)
        presentExerciseButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel?.presentWorkoutObserver.onNext(())
            }).disposed(by: disposeBag)
        
       Observable
        .zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(ExercisesList.self))
        .bind { indexPath, model in
            self.viewModel?.presentPreviewObserver.onNext((indexPath.row, model.rawValue))
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        view.add(collectionView, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing().bottom(tabBarHeight)
        })
        view.add(presentExerciseButton, layoutBlock: {
            $0.bottom(tabBarHeight + 15).centerX().width(Constants.sW / 2).height(34)
        })
    }
}

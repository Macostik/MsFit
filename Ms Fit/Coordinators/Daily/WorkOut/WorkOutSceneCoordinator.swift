//  
//  WorkOutSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WorkOutSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = WorkOutSceneViewModel(dependencies: dependencies)
        let viewController = WorkOutSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentObserver.subscribe(onNext: { [weak self] _ in
            self?.presentDetailsScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentPreviewStartObserver.subscribe(onNext: { [weak self] _ in
            self?.presentPreviewStartScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentDetailsScene() -> Observable<Void> {
        let detailCoordinator = DetailsWorkoutSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: detailCoordinator)
    }
    
    @discardableResult private func presentPreviewStartScene() -> Observable<Void> {
        let startCoordinator = PreviewStartSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: startCoordinator)
    }
}

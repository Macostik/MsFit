//  
//  DetailsWorkoutSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsWorkoutSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = DetailsWorkoutSceneViewModel(dependencies: dependencies)
        let viewController = DetailsWorkoutSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentPreviewStartObserver.subscribe(onNext: { [weak self] _ in
            self?.presentPreviewStartWorkoutScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentAllVideosObserver.subscribe(onNext: { [weak self] _ in
            self?.presentAllVideosScene()
        }).disposed(by: disposeBag)
                
        return Observable.just(())
    }
    
    @discardableResult private func presentPreviewStartWorkoutScene() -> Observable<Void> {
        let previewStartCoordinator = PreviewStartSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: previewStartCoordinator)
    }
    
    @discardableResult private func presentAllVideosScene() -> Observable<Void> {
        let allVideosCoordinator = AllVideosSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: allVideosCoordinator)
    }
}

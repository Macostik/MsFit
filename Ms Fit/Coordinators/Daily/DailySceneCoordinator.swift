//  
//  DailySceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DailySceneCoordinator: BaseTabBarSceneCoordinator<DailySceneViewModel> {
    
    override func controller() -> BaseViewController<DailySceneViewModel> {
        let viewModel = DailySceneViewModel(dependencies: dependencies)
        
        viewModel.questionPresentObserver.subscribe(onNext: { _ in
            self.presenQuestionsScene()
        }).disposed(by: disposeBag)
        
        viewModel.homePresentObserver.subscribe(onNext: { [weak self] _ in
            self?.presenHomeScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentWorkoutObserver.subscribe(onNext: { [weak self] _ in
            self?.presentWorkoutScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentMealObserver.subscribe(onNext: { [weak self] _ in
            self?.presentMealScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentPreviewStartObserver.subscribe(onNext: { [weak self] _ in
            self?.presentPreviewStartScene()
        }).disposed(by: disposeBag)
        
        viewModel.presentGeneralProgramObserver.subscribe(onNext: { [weak self] _ in
            self?.presentGeneralProgramScene()
        }).disposed(by: disposeBag)
        
        return DailySceneViewController.instantiate(with: viewModel)
    }
    
    @discardableResult private func presenQuestionsScene() -> Observable<Void> {
        let questionsCoordinator = QuestionsSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: questionsCoordinator)
    }
    
    @discardableResult private func presenHomeScene() -> Observable<Void> {
        let homeCoordinator = HomeSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: homeCoordinator)
    }
    
    @discardableResult private func presentWorkoutScene() -> Observable<Void> {
        let workoutCoordinator = WorkOutSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: workoutCoordinator)
    }
    
    @discardableResult private func presentMealScene() -> Observable<Void> {
        let mealCoordinator = MealSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: mealCoordinator)
    }
    
    @discardableResult private func presentPreviewStartScene() -> Observable<Void> {
        let startCoordinator = PreviewStartSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: startCoordinator)
    }
    
    @discardableResult private func presentGeneralProgramScene() -> Observable<Void> {
        let generalCoordinator = GeneralProgramSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: generalCoordinator)
    }
}

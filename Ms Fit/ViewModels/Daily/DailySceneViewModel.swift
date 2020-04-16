//  
//  DailySceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DailySceneViewModel: BaseViewModel<DailySceneModel> {
    
    public var questionPresentObserver = PublishSubject<Void>()
    public var homePresentObserver = PublishSubject<Void>()
    public var presentWorkoutObserver = PublishSubject<Void>()
    public var presentMealObserver = PublishSubject<Void>()
    
    override func performAction() {
        dependencies.dailyService.dailyScreen(completion: { [weak self] in
            self?.dependencies.mealsService.getMealsList()
        })
    }
}

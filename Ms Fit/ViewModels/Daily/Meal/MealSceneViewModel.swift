//  
//  MealSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MealSceneViewModel: BaseViewModel<MealSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
    public var presentMealsStoregeObserver = PublishSubject<Void>()
    public var presentSearchObserver = PublishSubject<Void>()
    public var presentLikeMealsObserver = PublishSubject<Void>()
    public var presentMealDetailObserver = PublishSubject<Int>()
}

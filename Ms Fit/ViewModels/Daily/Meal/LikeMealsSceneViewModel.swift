//  
//  LikeMealsSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 02.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LikeMealsSceneViewModel: BaseViewModel<LikeMealsSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
    public var presentMealsStoregeObserver = PublishSubject<Void>()
    public var presentMealDetailObserver = PublishSubject<Int>()
}

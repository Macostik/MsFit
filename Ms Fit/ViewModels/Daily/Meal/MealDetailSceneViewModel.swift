//  
//  MealDetailSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 27.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MealDetailSceneViewModel: BaseViewModel<MealDetailSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

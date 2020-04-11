//  
//  RestWorkoutSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 08.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class RestWorkoutSceneViewModel: BaseViewModel<RestWorkoutSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

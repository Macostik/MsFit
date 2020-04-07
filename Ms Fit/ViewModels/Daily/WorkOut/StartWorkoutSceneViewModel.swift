//  
//  StartWorkoutSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class StartWorkoutSceneViewModel: BaseViewModel<StartWorkoutSceneModel> {
    
    public var dismissDailySceneObserver = PublishSubject<Void>()
    public var dismissObserver = PublishSubject<Void>()
}

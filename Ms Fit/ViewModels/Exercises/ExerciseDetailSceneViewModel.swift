//  
//  ExerciseDetailSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ExerciseDetailSceneViewModel: BaseViewModel<ExerciseDetailSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

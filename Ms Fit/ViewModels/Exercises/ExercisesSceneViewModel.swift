//  
//  ExercisesSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ExercisesSceneViewModel: BaseViewModel<ExercisesSceneModel> {
    
    public var presentWorkoutObserver = PublishSubject<Void>()
    public var presentPreviewObserver = PublishSubject<(Int, String)>()
}

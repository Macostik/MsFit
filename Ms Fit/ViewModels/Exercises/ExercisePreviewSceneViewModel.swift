//  
//  ExercisePreviewSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ExercisePreviewSceneViewModel: BaseViewModel<ExercisePreviewSceneModel> {
    
    public var presentWorkoutObserver = PublishSubject<Void>()
    public var dismissObserver = PublishSubject<Void>()
}

//  
//  UpdateExerciseSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class UpdateExerciseSceneViewModel: BaseViewModel<UpdateExerciseSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

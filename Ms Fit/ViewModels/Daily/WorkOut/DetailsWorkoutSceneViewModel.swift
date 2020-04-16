//  
//  DetailsWorkoutSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailsWorkoutSceneViewModel: BaseViewModel<DetailsWorkoutSceneModel> {
    
    public var presentPreviewStartObserver = PublishSubject<Void>()
    public var dismissObserver = PublishSubject<Void>()
}

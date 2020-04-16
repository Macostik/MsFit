//  
//  PreviewStartSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PreviewStartSceneViewModel: BaseViewModel<PreviewStartSceneModel> {

    public var presentStartWorkoutObserver = PublishSubject<Void>()
    public var dismissObserver = PublishSubject<Void>()
}

//  
//  WorkOutSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class WorkOutSceneViewModel: BaseViewModel<WorkOutSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

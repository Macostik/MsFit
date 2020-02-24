//  
//  ForgotPassSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ForgotPassSceneViewModel: BaseViewModel<ForgotPassSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

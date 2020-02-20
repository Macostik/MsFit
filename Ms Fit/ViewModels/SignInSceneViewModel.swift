//  
//  SignInSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 19.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInSceneViewModel: BaseViewModel<SignInSceneModel> {
    
    public var presentLoginScreenObserver = PublishSubject<Void>()
    public var dismissObserver = PublishSubject<Void>()
}

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
    
    public var presentLoginScreen = PublishSubject<Void>()
    public var dismiss = PublishSubject<Void>()
}

//  
//  SignUpSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 21.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpSceneViewModel: BaseViewModel<SignUpSceneModel> {
    
    public let dismissObservable = PublishSubject<Void>()
    public let signUpObservable = PublishSubject<Void>()
}

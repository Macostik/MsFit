//  
//  NewRegistSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class NewRegistSceneViewModel: BaseViewModel<RegisterParamsModel> {
    
    public let dismissObservable = PublishSubject<Void>()
    public let presentSignUpObserver = PublishSubject<Void>()
    public var parameters = [String: String]()
}

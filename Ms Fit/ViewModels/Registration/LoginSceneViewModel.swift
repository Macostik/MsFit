//  
//  LoginSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginSceneViewModel: BaseViewModel<User> {
    
    public let presentForgotPassObserver = PublishSubject<Void>()
    public let presentMainScene = PublishSubject<Void>()
    public var dismissObserver = PublishSubject<Void>()
    public var tryLoginObserver: Observable<(String?, String?)>? {
        willSet {
            newValue?.subscribe(onNext: { [weak self] email, password in
                guard let email = email, let password = password,
                    email.isValidEmail, password.count > 5 else { return }
                self?.dependencies.loginService.login(email: email,
                                                      password: password,
                                                      completion: { [weak self] in
                                                        self?.presentMainScene.onNext(())
                })
            }).disposed(by: disposeBag)
        }
    }
}

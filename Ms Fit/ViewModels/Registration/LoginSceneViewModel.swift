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

final class LoginSceneViewModel: BaseViewModel<LoginSceneModel> {
    
    public let presentForgotPassObserver = PublishSubject<Void>()
    public var dismissObserver = PublishSubject<Void>()
    public var tryLoginObserver: Observable<(String?, String?)>? {
        willSet {
            newValue?.subscribe(onNext: { email, password in
                guard let email = email, let password = password,
                    email.isValidEmail, password.count > 5 else { return }
                APIManager.login(["email": email, "password": password]).json()
                .subscribe(onNext: { json in
                    print (">>self - \(json)<<")
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        }
    }
}

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

let deviceToken = "740f4707bebcf74f9b7c25d48e3358945f6aa01da5ddb387462c7eaf61bb78ad"

final class SignUpSceneViewModel: BaseViewModel<SignUpSceneModel> {
    
    public let dismissObservable = PublishSubject<Void>()
    public let presentMainSceneObservale = PublishSubject<Void>()
    public let signUpObservable = PublishSubject<[String: String]>()
    
    override func performAction() {
        signUpObservable
            .subscribe(onNext: { [weak self] params in
                self?.dependencies
                    .loginService.register(goal: params["goal"] ?? "",
                                           activity: params["activity"] ?? "",
                                           birthday: params["age"] ?? "",
                                           email: params["email"] ?? "",
                                           password: params["password"] ?? "",
                                           name: params["name"] ?? "",
                                           ios_device_token: deviceToken, completion: { [weak self] in
                                            self?.presentMainSceneObservale.onNext(())
                    })
            }).disposed(by: disposeBag)
    }
}

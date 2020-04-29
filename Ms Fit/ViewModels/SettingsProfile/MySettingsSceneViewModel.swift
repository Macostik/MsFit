//  
//  MySettingsSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class MySettingsSceneViewModel: BaseViewModel<Object> {
    
    public var dismissObserver = PublishSubject<Void>()
    public var dismissToLoginObserver = PublishSubject<Void>()
    public var presentContactUsObserver = PublishSubject<Void>()
    public var presentTermOfUseObserver = PublishSubject<Void>()
    public var presentAccountTypeObserver = PublishSubject<Void>()
    public var presentPrivacyPolicyObserver = PublishSubject<Void>()
    public var presentLevelSelectionObserver = PublishSubject<Void>()
    public var presentAccountSettingsObserver = PublishSubject<Void>()
    public var heightSceneObserver = PublishSubject<SettingsStorageSceneModel>()
}

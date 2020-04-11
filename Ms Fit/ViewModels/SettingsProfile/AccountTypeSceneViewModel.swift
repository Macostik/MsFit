//  
//  AccountTypeSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class AccountTypeSceneViewModel: BaseViewModel<AccountTypeSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

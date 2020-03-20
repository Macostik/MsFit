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

final class MySettingsSceneViewModel: BaseViewModel<MySettingsSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

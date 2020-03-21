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
}

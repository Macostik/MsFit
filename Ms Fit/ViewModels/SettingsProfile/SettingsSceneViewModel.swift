//  
//  SettingsSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class SettingsSceneViewModel: BaseViewModel<Object> {
    
    public var presentContactUsObserver = PublishSubject<Void>()
    public var presentMySettingsObserver = PublishSubject<Void>()
}

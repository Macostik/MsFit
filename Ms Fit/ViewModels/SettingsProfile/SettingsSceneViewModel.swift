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

final class SettingsSceneViewModel: BaseViewModel<SettingsSceneModel> {
    
    public var presentContactUsObserver = PublishSubject<Void>()
    public var presentMySettingsObserver = PublishSubject<Void>()
    public var presentUpdateMeasurementObserver = PublishSubject<Void>()

}

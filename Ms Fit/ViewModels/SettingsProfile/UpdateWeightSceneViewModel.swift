//  
//  UpdateWeightSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 01.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class UpdateWeightSceneViewModel: BaseViewModel<UpdateWeightSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

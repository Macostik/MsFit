//  
//  MealsStorageSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 11.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MealsStorageSceneViewModel: BaseViewModel<MealsStorageSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

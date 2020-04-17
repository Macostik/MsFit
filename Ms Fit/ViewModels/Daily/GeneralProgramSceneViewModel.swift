//  
//  GeneralProgramSceneViewModel.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 17.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class GeneralProgramSceneViewModel: BaseViewModel<GeneralProgramSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

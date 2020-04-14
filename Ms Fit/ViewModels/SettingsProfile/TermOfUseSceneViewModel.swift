//  
//  TermOfUseSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 14.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class TermOfUseSceneViewModel: BaseViewModel<TermOfUseSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

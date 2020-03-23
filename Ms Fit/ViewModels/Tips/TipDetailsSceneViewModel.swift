//  
//  TipDetailsSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 23.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class TipDetailsSceneViewModel: BaseViewModel<TipDetailsSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

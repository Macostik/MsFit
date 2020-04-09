//  
//  HistoryResultSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class HistoryResultSceneViewModel: BaseViewModel<HistoryResultSceneModel> {
    
    public var presentUpdateObserver = PublishSubject<(Int, String)>()
    public var dismissObserver = PublishSubject<Void>()
}

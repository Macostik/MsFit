//  
//  SentMessageSceneViewModel.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 09.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SentMessageSceneViewModel: BaseViewModel<SentMessageSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

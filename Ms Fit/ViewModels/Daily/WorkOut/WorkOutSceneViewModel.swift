//  
//  WorkOutSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class WorkOutSceneViewModel: BaseViewModel<Object> {
    
    public var dismissObserver = PublishSubject<Void>()
    public var presentObserver = PublishSubject<(Int, String)>()
}

//  
//  HomeSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 26.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class HomeSceneViewModel: BaseViewModel<Object> {
    
    public var dismissObserver = PublishSubject<Void>()
}

//  
//  DetailFoodSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 31.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailFoodSceneViewModel: BaseViewModel<DetailFoodSceneModel> {
    
    public let dismissObserver = PublishSubject<Void>()
}

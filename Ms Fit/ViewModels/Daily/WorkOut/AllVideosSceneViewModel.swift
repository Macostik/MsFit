//  
//  AllVideosSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class AllVideosSceneViewModel: BaseViewModel<AllVideosSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

//  
//  SplashSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import Action

final class SplashSceneViewModel: BaseViewModel<Int> {
    
    public let pushObservable = PublishSubject<Int>()
    
    override init(dependencies: Dependency) {
        super.init(dependencies: dependencies)
        Observable<Int>.timer(.milliseconds(Constants.splashTimeAnimation),
                              scheduler: MainScheduler.instance)
            .subscribe(pushObservable)
            .disposed(by: disposeBag)
    }
}

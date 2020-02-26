//  
//  DailySceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DailySceneViewModel: BaseViewModel<DailySceneModel> {
    
    public var splashObserver = PublishSubject<Void>()
    public var splashHomeObserver = PublishSubject<Void>()
    
    public var questionClickObserver: Observable<Void>? {
        willSet {
            newValue?.subscribe(onNext: { _ in
                self.splashObserver.onNext(())
            }).disposed(by: disposeBag)
        }
    }
    
    public var homeClickObserver: Observable<Void>? {
        willSet {
            newValue?.subscribe(onNext: { _ in
                self.splashHomeObserver.onNext(())
            }).disposed(by: disposeBag)
        }
    }
}

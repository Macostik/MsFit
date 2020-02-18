//
//  BaseViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import RealmSwift
import RxRealm

class BaseViewModel<T> {

    public var dependencies: Dependency
    public var elements: Driver<[T]>?
    public let loadError: Driver<Error>
    public var indicatorViewAnimating: Driver<Bool>
    public var loadAction: Action<T, T>
    
    public let disposeBag = DisposeBag()
    
    init(dependencies: Dependency) {
        self.dependencies = dependencies
        loadAction = Action { .just($0) }
        indicatorViewAnimating = loadAction.executing.asDriver(onErrorJustReturn: false)
        loadError = loadAction.errors.asDriver(onErrorDriveWith: .empty())
            .flatMap { error -> Driver<Error> in
                switch error {
                case .underlyingError(let error):
                    return Driver.just(error)
                case .notEnabled:
                    return Driver.empty()
                }
        }
        performAction()
    }
    internal func performAction() {}
}

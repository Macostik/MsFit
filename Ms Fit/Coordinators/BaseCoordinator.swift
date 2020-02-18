//
//  BaseCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import RxSwift
import Foundation

open class BaseCoordinator<ResultType> {
    
    typealias CoordinationResult = ResultType
    
    public let disposeBag = DisposeBag()
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    public func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in self?.free(coordinator: coordinator) })
    }
    
    public func start() -> Observable<ResultType> {
        fatalError("Start method should be implemented.")
    }
}

open class BaseSceneCoordinator<T>: BaseCoordinator<T> {
    
    internal let window: UIWindow
    internal let dependencies: Dependency
    
    init(window: UIWindow, dependencies: Dependency) {
        self.window = window
        self.dependencies = dependencies
    }
}

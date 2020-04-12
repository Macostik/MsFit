//  
//  NewRegistSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewRegistSceneCoordinator: BaseSceneCoordinator<Void> {
    
    public var pickerElement = PickerData.weight
    public var isProceed = false
    
    override func start() -> Observable<Void> {
        let viewModel = NewRegistSceneViewModel(dependencies: dependencies)
        let viewController = NewRegistSceneViewController.instantiate(with: viewModel)
        viewController.pickerElement = pickerElement
        viewController.verForButtonStackView.isHidden = isProceed
        viewController.pickerView.isHidden = !isProceed
        viewController.showOneScene = isProceed
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.presentSignUpObserver
            .flatMap({ Observable.just(viewModel.parameters)  })
            .subscribe(onNext: { [weak self] params in
                self?.presentSignUpScene(with: params)
            }).disposed(by: disposeBag)
        
        viewModel.dismissObservable.subscribe(onNext: { _ in
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentSignUpScene(with params: [String: String]) -> Observable<Void> {
        let validationCoordinator = SignUpSceneCoordinator(window: window, dependencies: dependencies)
        validationCoordinator.userParams = params
        return coordinate(to: validationCoordinator)
    }
}

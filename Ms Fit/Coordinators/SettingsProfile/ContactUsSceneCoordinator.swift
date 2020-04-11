//  
//  ContactUsSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContactUsSceneCoordinator: BaseSceneCoordinator<Void> {
    
    override func start() -> Observable<Void> {
        let viewModel = ContactUsSceneViewModel(dependencies: dependencies)
        let viewController = ContactUsSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.dismissObserver.subscribe(onNext: {
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.presentSentMessageObserver.subscribe(onNext: { [weak self] _ in
            self?.presentSentMessageScene()
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
    
    @discardableResult private func presentSentMessageScene() -> Observable<Void> {
        let messageCoordinator = SentMessageSceneCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: messageCoordinator)
    }
}

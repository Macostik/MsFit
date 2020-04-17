//  
//  DetailFoodSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 31.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Navigator {
    case push
    case present
}

class DetailFoodSceneCoordinator: BaseSceneCoordinator<Void> {
    
    public var navigator = Navigator.present
    
    override func start() -> Observable<Void> {
        let viewModel = DetailFoodSceneViewModel(dependencies: dependencies)
        let viewController = DetailFoodSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        
        if navigator == .present {
            navigationController?.present(viewController, animated: true, completion: nil)
        } else {
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        viewModel.dismissObserver.subscribe(onNext: { [unowned self]_ in
            if self.navigator == .present {
                navigationController?.dismiss(animated: true, completion: nil)
            } else {
                navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
        
        return Observable.just(())
    }
}

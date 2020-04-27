//  
//  TipsSceneCoordinator.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TipsSceneCoordinator: BaseTabBarSceneCoordinator<TipsSceneViewModel> {
    
    override func controller() -> BaseViewController<TipsSceneViewModel> {
        let viewModel = TipsSceneViewModel(dependencies: dependencies)
        
        viewModel.presentDetailsObserver.subscribe(onNext: { arg in
            self.presentDetailsUsScene(tipsID: arg.1)
        }).disposed(by: disposeBag)
        
        return TipsSceneViewController.instantiate(with: viewModel)
    }
    
    @discardableResult private func presentDetailsUsScene(tipsID: String) -> Observable<Void> {
        let tipDetailsCoordinator = TipDetailsSceneCoordinator(window: window, dependencies: dependencies)
        tipDetailsCoordinator.tipsID = tipsID
        return coordinate(to: tipDetailsCoordinator)
    }
}

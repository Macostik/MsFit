//  
//  MainSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MainSceneViewModel: BaseViewModel<UIViewController> {
    
    public var item: Observable<UIViewController>? {
           willSet {
               newValue?.asObservable()
                   .subscribe(loadAction.inputs)
                   .disposed(by: disposeBag)
           }
       }
}

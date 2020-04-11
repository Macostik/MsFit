//  
//  EditPasswordSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class EditPasswordSceneViewModel: BaseViewModel<EditPasswordSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
}

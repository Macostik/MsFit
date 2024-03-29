//  
//  ContactUsSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ContactUsSceneViewModel: BaseViewModel<ContactUsSceneModel> {
    
    public var presentSentMessageObserver = PublishSubject<Void>()
    public var dismissObserver = PublishSubject<Void>()
}

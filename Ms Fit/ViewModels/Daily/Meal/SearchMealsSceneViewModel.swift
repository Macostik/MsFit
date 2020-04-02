//  
//  SearchMealsSceneViewModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 13.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchMealsSceneViewModel: BaseViewModel<SearchMealsSceneModel> {
    
    public var dismissObserver = PublishSubject<Void>()
    public var presentMealsStoregeObserver = PublishSubject<Void>()
    public var presentDetailFoodObserver = PublishSubject<(Int, String)>()
}

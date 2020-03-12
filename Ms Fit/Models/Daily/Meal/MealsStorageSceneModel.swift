//  
//  MealsStorageSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 11.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift
import RxDataSources

//it should be replaced to correct data

enum MealsStorageData: CaseIterable {
    case settings, support, empty
    
    func description() -> SectionOfMeal {
        switch self {
        case .settings:
            return SectionOfMeal(header: "SETTINGS",
                                 items: [MealsStorageSceneModel.sound, MealsStorageSceneModel.vibration])
        case .support:
            return SectionOfMeal(header: "SUPPORT",
                                 items: [MealsStorageSceneModel.changeColor, MealsStorageSceneModel.support])
        case .empty:
            return SectionOfMeal(header: "",
                                 items: [MealsStorageSceneModel.share,
                                         MealsStorageSceneModel.rate,
                                         MealsStorageSceneModel.policy])
        }
    }
}

struct SectionOfMeal {
    var header: String
    var items: [Item]
}
extension SectionOfMeal: SectionModelType {
    typealias Item = MealsStorageSceneModel
    
    init(original: SectionOfMeal, items: [Item]) {
        self = original
        self.items = items
    }
}

enum MealsStorageSceneModel: String, CaseIterable {
    case sound, vibration, changeColor, support, share, rate, policy
    
    func description() -> (String, Bool) {
        switch self {
        case .sound:
            return ("Sound", true)
        case .vibration:
            return ("Vibration", true)
        case .changeColor:
            return ("How to Color", false)
        case .support:
            return ("Contact Support", false)
        case .share:
            return ("Share App", false)
        case .rate:
            return ("Rate Us", false)
        case .policy:
            return ("Privacy Policy", false)
            
        }
    }
}


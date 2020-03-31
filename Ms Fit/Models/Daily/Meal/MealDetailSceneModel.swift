//  
//  MealDetailSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 27.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class MealDetailSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum AddFeedsModel: String, CaseIterable {
    case food1, food2, food3, food4, food5, food6, food7, food8, food9, food10
    
    func description() -> String {
        switch self {
        case .food1:
            return "98 kcal"
        case .food2:
            return "90 kcal"
        case .food3:
            return "267 kcal"
        case .food4:
            return "824 kcal"
        case .food5:
            return "235 kcal"
        case .food6:
            return "100 kcal"
        case .food7:
            return "20 kcal"
        case .food8:
            return "89 kcal"
        case .food9:
            return "41 kcal"
        case .food10:
            return "65 kcal"
        }
    }
}

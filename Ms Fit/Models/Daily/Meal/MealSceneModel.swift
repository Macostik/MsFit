//  
//  MealSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class MealSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum BreakfastList: String, CaseIterable {
    case food1
    case food2
    case food3
    case food4
    case food5
    case food6
    case food7
    case food8
    
    func description() -> (String, String) {
        switch self {
        case .food1:
            return ("Chicken breast with rice", "195 kcal")
        case .food2:
            return ("Chicken breast with rice", "233  kcal")
        case .food3:
            return ("Chicken breast with rice", "145  kcal")
        case .food4:
            return ("Chicken breast with rice", "153  kcal")
        case .food5:
            return ("Chicken breast with rice", "167  kcal")
        case .food6:
            return ("Chicken breast with rice", "243  kcal")
        case .food7:
            return ("Chicken breast with rice", "400  kcal")
        case .food8:
            return ("Chicken breast with rice", "321  kcal")
        }
    }
}

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
    case food1, food2, food3, food4, food5, food6, food7, food8
    
    func description() -> (String, String) {
        switch self {
        case .food1:
            return ("صدر دجاج مع الرز", "195 kcal")
        case .food2:
            return ("صدر دجاج مع الرز", "233  kcal")
        case .food3:
            return ("صدر دجاج مع الرز", "145  kcal")
        case .food4:
            return ("صدر دجاج مع الرز", "153  kcal")
        case .food5:
            return ("صدر دجاج مع الرز", "167  kcal")
        case .food6:
            return ("صدر دجاج مع الرز", "243  kcal")
        case .food7:
            return ("صدر دجاج مع الرز", "400  kcal")
        case .food8:
            return ("صدر دجاج مع الرز", "321  kcal")
        }
    }
}

enum LunchList: String, CaseIterable {
    case breakfast
    case snack1
    case lunch
    case snack2
    case dinner
    
    func description() -> (String) {
        switch self {
        case .breakfast:
            return ("وجبة افطار")
        case .snack1:
            return ("وجبة خفيفة 1")
        case .lunch:
            return ("غداء")
        case .snack2:
            return ("وجبة خفيفة 2")
        case .dinner:
            return ("وجبة عشاء")
        }
    }
}

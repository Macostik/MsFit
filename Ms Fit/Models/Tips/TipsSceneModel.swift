//  
//  TipsSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class TipsSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum TipsMenuModel: String, CaseIterable {
    case AllCategories, Favorites, Health, Food, Recipes
}

enum TipsModel: String, CaseIterable {
    case food1, food2, food3, food4, food5, food6, food7, food8
    
    func description() -> String {
        switch self {
        case .food1:
            return ("Committing to a longer subscription increases your success rate")
        case .food2:
            return ("Committing to a longer subscription ")
        case .food3:
            return ("Committing to a longer subscription")
        case .food4:
            return ("Committing to a longer subscription increases your success rate")
        case .food5:
            return ("Committing to a longer subscription increases your success rate")
        case .food6:
            return ("Committing to a longer subscription ")
        case .food7:
            return ("Committing to a longer subscription")
        case .food8:
            return ("Committing to a longer subscription increases your success rate")
        }
    }
}

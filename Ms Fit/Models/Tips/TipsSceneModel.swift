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
    case التصنيفات, المفضلة, الصحة, طعام, وصفات
}

enum TipsModel: String, CaseIterable {
    case food1, food2, food3, food4, food5, food6, food7, food8
    
    func description() -> String {
        switch self {
        case .food1:
            return ("الالتزام باشتراك أطول")
        case .food2:
            return ("الالتزام باشتراك أطول")
        case .food3:
            return ("الالتزام باشتراك أطول")
        case .food4:
            return ("الالتزام باشتراك أطول")
        case .food5:
            return ("الالتزام باشتراك أطول")
        case .food6:
            return ("الالتزام باشتراك أطول")
        case .food7:
            return ("الالتزام باشتراك أطول")
        case .food8:
            return ("الالتزام باشتراك أطول")
        }
    }
}

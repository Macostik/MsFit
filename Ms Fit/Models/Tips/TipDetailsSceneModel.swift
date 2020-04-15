//  
//  TipDetailsSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 23.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class TipDetailsSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum TipsDetailModel: String, CaseIterable {
    case food1, food2
    
    func description() -> String {
        switch self {
        case .food1:
            return ("الالتزام باشتراك أطول")
        case .food2:
            return ("الالتزام باشتراك أطول")
        }
    }
}

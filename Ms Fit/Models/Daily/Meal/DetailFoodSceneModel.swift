//  
//  DetailFoodSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 31.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class DetailFoodSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//  
//  LikeMealsSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 02.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class LikeMealsSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

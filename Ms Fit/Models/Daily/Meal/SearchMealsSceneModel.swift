//  
//  SearchMealsSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 13.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class SearchMealsSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum HeaderModel: String, CaseIterable {
    case فاكهة, يشرب, الصلصات, وجباتخفيفة
}

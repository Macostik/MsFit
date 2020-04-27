//  
//  DailySceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class DailySceneModel: Object {
    
    @objc dynamic public var id = UUID().uuidString
    @objc dynamic public var day_number = 0
    @objc dynamic public var exercises_amount: String?
    @objc dynamic public var meals_amount: String?
    @objc dynamic public var show_month_rate = false
    @objc dynamic public var verified = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class TipsPost: Object {
    @objc dynamic public var id = ""
    @objc dynamic public var title = ""
    @objc dynamic public var picture = ""
    @objc dynamic public var category = ""
    @objc dynamic public var content = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


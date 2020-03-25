//  
//  User.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class User: Object {
    
    @objc dynamic public var id = 0
    @objc dynamic public var role = 0
    @objc dynamic public var is_verified = 0
    @objc dynamic public var name = ""
    @objc dynamic public var email = ""
    @objc dynamic public var avatar = ""
    @objc dynamic public var client = ""
    @objc dynamic public var updated_at = ""
    @objc dynamic public var created_at = ""
    @objc dynamic public var last_activity = ""
    
    @objc dynamic public var version = ""
    @objc dynamic public var api_token = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

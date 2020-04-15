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
    @objc dynamic public var avatar: String?
    @objc dynamic public var client: String?
    @objc dynamic public var updated_at: String?
    @objc dynamic public var created_at: String?
    @objc dynamic public var last_activity: String?
    
    @objc dynamic public var version: String?
    @objc dynamic public var api_token = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Program: Object {
    
    @objc dynamic public var id = 0
    @objc dynamic public var name = ""
    @objc dynamic public var type = 0
    @objc dynamic public var is_active = 0
    let program_levels = List<ProgramLevels>()
        
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class ProgramLevels: Object {
    
    @objc dynamic public var id = 0
    @objc dynamic public var level = 0
    @objc dynamic public var duration = 0
    @objc dynamic public var rest = 0
        
    override static func primaryKey() -> String? {
        return "id"
    }
}

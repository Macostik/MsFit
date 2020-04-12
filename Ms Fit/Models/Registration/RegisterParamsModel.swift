//  
//  NewRegistSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class RegisterParamsModel: Object {
    
    @objc dynamic public var id = 0
    @objc dynamic public var goal = ""
    @objc dynamic public var activity = ""
    @objc dynamic public var birthday = ""
    @objc dynamic public var deviceToken = UIDevice.current.identifierForVendor!.uuidString
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

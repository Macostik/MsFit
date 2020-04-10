//  
//  EditPasswordSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class EditPasswordSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum EditPasswordModel: String, CaseIterable {
    case oldPassword, newPassword
}

//  
//  ProfileSceneModel.swift
//  
//
//  Created by Yura Granchenko on 22.02.2020.
//

import UIKit
import RealmSwift

final class ProfileSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//  
//  SentMessageSceneModel.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 09.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class SentMessageSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

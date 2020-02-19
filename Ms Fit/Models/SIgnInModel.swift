//  
//  SIgnInModel.swift
//  Ms Fit
//
//  Created by Maxim Granchenko on 19.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class SIgnInModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

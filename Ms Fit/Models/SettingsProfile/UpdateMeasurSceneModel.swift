//  
//  UpdateMeasurSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 21.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class UpdateMeasurSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum UpdateMeasurementModel: String, CaseIterable {
    case chest, waist, legs, arm
    
    func description() -> (String, String, UIImage) {
        switch self {
        case .chest:
            return ("الصدر", "67.0 cm", UIImage(named: "chest")!)
        case .waist:
            return ("الخصر", "25.0 cm", UIImage(named: "waist")!)
        case .legs:
            return ("الفخذ", "60.0 cm", UIImage(named: "legs")!)
        case .arm:
            return ("اليد", "40.0 cm", UIImage(named: "arm")!)
        }
    }
}

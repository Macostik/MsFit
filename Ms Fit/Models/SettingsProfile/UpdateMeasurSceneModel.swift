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
    
    func description() -> (String, String) {
        switch self {
        case .chest:
            return ("Chest", "67.0 cm")
        case .waist:
            return ("Waist", "25.0 cm")
        case .legs:
            return ("Thigh", "60.0 cm")
        case .arm:
            return ("Arms", "40.0 cm")
        }
    }
}

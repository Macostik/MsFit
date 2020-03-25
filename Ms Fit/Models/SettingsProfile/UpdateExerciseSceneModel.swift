//  
//  UpdateExerciseSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class UpdateExerciseSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum UpdatePickerData: String, CaseIterable {
    case chest
    case waist
    case thigh
    case arms
    
    func dataList() -> PickerListEntryType {
        switch self {
        case .chest:
            return [Array(60...140).map({"\($0)"}), Array(0...9).map({".\($0) cm"})]
        case .waist:
            return [Array(20...150).map({"\($0)"}), Array(0...9).map({".\($0) cm"})]
        case .thigh:
            return [Array(25...250).map({"\($0)"}), Array(0...9).map({".\($0) cm"})]
        case .arms:
            return [Array(10...60).map({"\($0)"}), Array(0...9).map({".\($0) cm"})]
        }
    }
}

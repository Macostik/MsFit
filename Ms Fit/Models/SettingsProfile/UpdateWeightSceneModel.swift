//  
//  UpdateWeightSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 01.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class UpdateWeightSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum WeightPickerData: String, CaseIterable {
    case weight
    
    func dataList() -> PickerListEntryType {
        switch self {
        case .weight:
            return [Array(0...9).map({".\($0) kg"}), Array(40...140).map({"\($0)"})]
        }
    }
}

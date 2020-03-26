//  
//  HistoryResultSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class HistoryResultSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum HistoryModel: String, CaseIterable {
    case jun, july, oct, nov
    
    func description() -> (String, String) {
        switch self {
        case .jun:
            return ("2019 ,31 Juny", "67.0 kg")
        case .july:
            return ("2019 ,10 July", "25.0 kg")
        case .oct:
            return ("2019 ,05 October", "60.0 kg")
        case .nov:
            return ("2019 ,20 November", "40.0 kg")
        }
    }
}

//  
//  OnboardSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

enum ImageList: String, CaseIterable {
    case splash_1
    case splash_2
    case splash_3
    
    func description() -> String {
        switch self {
        case .splash_1:
            return ("Coach for You")
        case .splash_2:
            return ("Activity Program")
        case .splash_3:
            return ("Personal Diet")
        }
    }
}

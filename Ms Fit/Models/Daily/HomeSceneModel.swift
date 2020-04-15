//  
//  HomeSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 26.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

enum HomeImageList: String, CaseIterable {
    case everydayExercise
    case measurements
    case meals
    case motivation
    
    func description() -> (String, String) {
        switch self {
        case .everydayExercise:
            return ("تمارين يومية", "الالتزام باشتراك أطول يزيد من معدل نجاحك")
        case .measurements:
            return ("قياسات", "الالتزام باشتراك أطول")
        case .meals:
            return ("وجبات", "الالتزام باشتراك أطول")
        case .motivation:
            return ("التحفيز", "الالتزام بزيادة الاشتراك أطول")
        }
    }
}

enum DetailsImageList: String, CaseIterable {
    case arm_rotations, push_ups, crunches
}

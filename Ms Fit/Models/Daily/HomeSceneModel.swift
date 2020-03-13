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
            return ("everyday Exercises", "Committing to a longer subscription increases your success rate")
        case .measurements:
            return ("measurements", "Committing to a longer subscription ")
        case .meals:
            return ("meals", "Committing to a longer subscription")
        case .motivation:
            return ("motivation", "Committing to a longer subscription increases your success rate")
        }
    }
}

enum DetailsImageList: String, CaseIterable {
    case arm_rotations, push_ups, crunches
}

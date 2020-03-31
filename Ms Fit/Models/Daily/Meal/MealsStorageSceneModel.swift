//  
//  MealsStorageSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 11.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift
import RxDataSources

enum MealsStorageSceneModel: String, CaseIterable {
    case breakfast, lauch, snack, dinner
    
    func getImage() -> (UIImage?) {
        switch self {
        case .breakfast:
            return UIImage(named: "Breakfast")
        case .lauch:
            return UIImage(named: "Lunch")
        case .snack:
            return UIImage(named: "snack1")
        case .dinner:
            return UIImage(named: "Dinner")
        }
    }
}

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
    case breakfast, snack1, lauch, snack2, dinner
    
    func getImage() -> (UIImage?) {
        switch self {
        case .breakfast:
            return UIImage(named: "breakfast")
        case .snack1:
            return UIImage(named: "snack1")
        case .lauch:
            return UIImage(named: "lunch")
        case .snack2:
            return UIImage(named: "snack2")
        case .dinner:
            return UIImage(named: "dinner")
        }
    }
}

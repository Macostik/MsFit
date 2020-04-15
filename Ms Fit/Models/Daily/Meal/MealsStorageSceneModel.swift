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
    case وجبةافطار, وجبةخفيفة1, لاوش, وجبةخفيفة2, وجبةعشاء
    
    func getImage() -> (UIImage?) {
        switch self {
        case .وجبةافطار:
            return UIImage(named: "breakfast")
        case . وجبةخفيفة1:
            return UIImage(named: "snack1")
        case .لاوش:
            return UIImage(named: "lunch")
        case .وجبةخفيفة2:
            return UIImage(named: "snack2")
        case .وجبةعشاء:
            return UIImage(named: "dinner")
        }
    }
}

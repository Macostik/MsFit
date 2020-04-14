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
    case splash_3
    case splash_2
    case splash_1
    
    func description() -> (String, String) {
        switch self {
        case .splash_3:
            return ("جدول رياضي", "تمارين رياضية مناسبة للمنزل أو الجيمتساعدك في الوصول للجسم المثالي بسهوله")
        case .splash_2:
            return ("جدول غذائي", "وجبات صحية شهية ومتجددةمصممة لتناسب احتياجك اليومي من السعرات")
        case .splash_1:
            return ("متابعة الأداء", "سجل قياسات شامل وسهليساعدك في قياس نتائجك ومتابعة تغير جسمك")
        }
    }
}

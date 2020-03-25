//
//  Constants.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import Foundation

//height controls
let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
    .map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
let navigationBarHeight = 44 + (keyWindow?.safeAreaInsets.bottom ?? 0)
let tabBarHeight = 44 + (keyWindow?.safeAreaInsets.bottom ?? 0)
let rootViewController = UIApplication.shared.windows.first?.rootViewController?.view

struct Constants {
    static let baseURL = Environment.isProduction ? "http://msfit.selectotech.com/api/v2" :
        Environment.isDevelop ? "http://msfit.selectotech.com/api/v2" :
    "http://msfit.selectotech.com/api/v2"
    static let splashTimeAnimation = 3000
    static let groupId = ""
    static let sW = UIScreen.main.bounds.width
    static let sH = UIScreen.main.bounds.height
    static let sH_812 = UIScreen.main.bounds.height >= 812
    static let sH_667 = UIScreen.main.bounds.height >= 667
}

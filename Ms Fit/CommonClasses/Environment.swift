//
//  Environment.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation

struct Environment {
    
    static let ENV = Bundle.main.object(forInfoDictionaryKey: "Environment") as? String ?? "DEV"
    static var DEV = "DEV"
    static var STG = "STG"
    static var PROD = "PROD"
    
    static let isProduction = ENV == PROD
    static let isDevelop = ENV == DEV
}

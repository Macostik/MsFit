//
//  Int+Ext.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation

extension Int {
    func applyToCount() -> String {
        if self % 10 == 1 {
            return "مرة"
        } else if (2...4).contains(self % 10) {
            return "مرات"
        } else {
            return "مرة"
        }
    }
}

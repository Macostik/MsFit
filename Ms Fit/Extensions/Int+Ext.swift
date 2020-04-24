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
    
    func minutesToTime() -> String {
        let (_,m,_) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        //        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        //    let s_string =  s < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(m_string)"
    }
}

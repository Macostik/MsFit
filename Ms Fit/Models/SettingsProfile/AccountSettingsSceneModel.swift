//  
//  AccountSettingsSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class AccountSettingsSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum AccountModel: String, CaseIterable {
    case email, name, location, editPassword
    
    func discription() -> (String, String) {
        switch self {
        case .email:
            return ("البريد الإلكتروني", "yura.test@mail.com")
        case .name:
            return ("اسم المستخدم", "Yura IOS Test")
        case .location:
            return ("موقعك", "Kharkiv")
        case .editPassword:
            return ("تحرير كلمة المرور", "")
        }
    }
}

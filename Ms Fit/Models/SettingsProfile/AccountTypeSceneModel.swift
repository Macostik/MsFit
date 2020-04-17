//  
//  AccountTypeSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

final class AccountTypeSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum AccountTypeModel: String, CaseIterable {
    case نوعالحساب, نشيط

    func discription() -> String {
        switch self {
        case .نوعالحساب:
            return "العضوية"
        case .نشيط
:
            return "حتى 23/04/2020"
        }
    }
}

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
    case accountType, active
    
    func discription() -> String {
        switch self {
        case .accountType:
            return "General Membership"
        case .active:
            return "Until 23/04/2020"
        }
    }
}

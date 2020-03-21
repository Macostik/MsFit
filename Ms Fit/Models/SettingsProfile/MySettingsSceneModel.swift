//  
//  MySettingsSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift
import RxDataSources

enum SettingsStorageData: CaseIterable {
    case settings, account, msFit, empty
    
    func description() -> SectionOfSettings {
        switch self {
        case .settings:
            return SectionOfSettings(header: "PROFILE SETTINGS",
                                     items: [.goal, .heigth, .startWeight, .dateOfBirth,
                                             .activity, .workoutType])
        case .account:
            return SectionOfSettings(header: "ACCOUNT",
                                     items: [.accountSettings, .accountType])
        case .msFit:
            return SectionOfSettings(header: "MS FIT",
                                     items: [.contactUs, .aboutApp, .privacyPolicy, .termOfUse, .version])
        case .empty:
            return SectionOfSettings(header: "",
                                     items: [.logOut])
        }
    }
}

struct SectionOfSettings {
    var header: String
    var items: [Item]
}
extension SectionOfSettings: SectionModelType {
    typealias Item = SettingsStorageSceneModel
    
    init(original: SectionOfSettings, items: [Item]) {
        self = original
        self.items = items
    }
}

enum SettingsStorageSceneModel: String, CaseIterable {
    case goal, heigth, startWeight, dateOfBirth, activity, workoutType, accountSettings, accountType,
    contactUs, aboutApp, privacyPolicy, termOfUse, version, logOut
    
    func description() -> (String, String) {
        switch self {
        case .goal:
            return ("Goal", "Gain Weight")
        case .heigth:
            return ("Height", "170 cm")
        case .startWeight:
            return ("Start Weight", "62 kg")
        case .dateOfBirth:
            return ("Date of birth", "01/11/2020")
        case .activity:
            return ("Activity", "Destop job")
        case .workoutType:
            return ("Workout Type", "Gym")
        case .accountSettings:
            return ("Account Settings", "")
        case .accountType:
            return ("Account Type", "General Membership")
        case .contactUs:
            return ("Contact Us", "")
        case .aboutApp:
            return ("About app", "")
        case .privacyPolicy:
            return ("Private Policy", "")
        case .termOfUse:
            return ("Term of use", "")
        case .version:
            return ("Version", "1.0")
        case .logOut:
            return ("Log Out", "")
        }
    }
}



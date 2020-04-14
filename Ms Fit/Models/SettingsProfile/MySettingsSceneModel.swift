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
            return SectionOfSettings(header: "الإعدادات",
                                     items: [.weight, .heigth, .dateOfBirthday, .goal,
                                             .activity, .selectionLevel])
        case .account:
            return SectionOfSettings(header: "الحساب",
                                     items: [.accountSettings, .accountType])
        case .msFit:
            return SectionOfSettings(header: "MS FIT",
                                     items: [.contactUs, .aboutApp, .privacyPolicy,
                                             .termOfUse, .notification, .version])
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
    case weight, heigth, dateOfBirthday, goal, activity, selectionLevel, accountSettings, accountType,
    contactUs, aboutApp, privacyPolicy, termOfUse, version, notification, logOut
    
    func description() -> (String, String) {
        switch self {
        case .weight:
            return ("Weight", "140.9 kg")
        case .heigth:
            return ("الطول", "cm 200")
        case .dateOfBirthday:
            return ("تاريخ الميلاد", "01/11/2020")
        case .goal:
            return ("الهدف", "my goal is 130 kg")
        case .activity:
            return ("النشاط اليومي", "وظيفة مكتبية")
        case .selectionLevel:
            return ("Workout Type", "2 level")
        case .accountSettings:
            return ("إعدادات الحساب", "")
        case .accountType:
            return ("العضوية", "General Membership")
        case .contactUs:
            return ("الاتصال بنا", "")
        case .aboutApp:
            return ("عن التطبيق", "")
        case .privacyPolicy:
            return ("سياسة الخصوصية", "")
        case .termOfUse:
            return ("شروط الاستخدام", "")
        case .version:
            return ("الإصدار" , "1.0")
        case .notification:
            return ("Notification", "")
        case .logOut:
            return ("تسجيل خروج", "")
        }
    }
}

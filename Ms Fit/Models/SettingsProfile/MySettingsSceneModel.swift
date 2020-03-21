//  
//  MySettingsSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

import UIKit
import RealmSwift
import RxDataSources

enum SettingsStorageData: CaseIterable {
    case settings, support, empty
    
    func description() -> SectionOfSettings {
        switch self {
        case .settings:
            return SectionOfSettings(header: "SETTINGS",
                                 items: [SettingsStorageSceneModel.sound, SettingsStorageSceneModel.vibration])
        case .support:
            return SectionOfSettings(header: "SUPPORT",
                                 items: [SettingsStorageSceneModel.changeColor, SettingsStorageSceneModel.support])
        case .empty:
            return SectionOfSettings(header: "",
                                 items: [SettingsStorageSceneModel.share,
                                         SettingsStorageSceneModel.rate,
                                         SettingsStorageSceneModel.policy])
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
    case sound, vibration, changeColor, support, share, rate, policy
    
    func description() -> (String, Bool) {
        switch self {
        case .sound:
            return ("Sound", true)
        case .vibration:
            return ("Vibration", true)
        case .changeColor:
            return ("How to Color", false)
        case .support:
            return ("Contact Support", false)
        case .share:
            return ("Share App", false)
        case .rate:
            return ("Rate Us", false)
        case .policy:
            return ("Privacy Policy", false)
            
        }
    }
}



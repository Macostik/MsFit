//
//  DailyService.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 11.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RealmSwift

class DailyService: RealmService<DailySceneModel> {
    
    public func dailyScreen(completion: (() -> ())? = nil) {
        let realm = RealmProvider.shared.realm
        guard let user = realm.objects(User.self).first else { return }
        APIManager.daily_screen(["api_token": user.api_token,
                                 "version": "2.1.13",
                                 "client": "ios"]).json()
            .subscribe(onNext: { json in
                do {
                    try realm.write {
                        let data = json["data"]
                        if !data.isEmpty {
                            realm.create(T.self, value: data.object, update: .modified)
                            Logger.info("DailyScreen was create successfully")
                            completion?()
                        }
                    }
                } catch let error {
                    Logger.error("DataBase of Realm was changed \(error)")
                }
            }).disposed(by: disposeBag)
    }
}

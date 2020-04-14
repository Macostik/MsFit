//
//  DailyService.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 11.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation
import RealmSwift

class DailyService: RealmService<User> {
    
    public func dailyScreen() {
//        let realm = RealmProvider.shared.realm
//        guard let user = realm.objects(User.self).first else { return }
//        APIManager.daily_screen(["api_token": user.api_token,
//                                 "version": user.version,
//                                 "client": user.client]).json()
//            .subscribe(onNext: { json in
//                do {
//                    try realm.write {
//                        let data = json["data"]
//                        if !data.isEmpty {
//                            print (">>self - \(json)<<")
////                            realm.create(T.self, value: data.object, update: .modified)
////                            Logger.info("User was create successfully")
//                        }
//                    }
//                } catch let error {
//                    Logger.error("DataBase of Realm was changed \(error)")
//                }
//            }).disposed(by: disposeBag)
    }
}

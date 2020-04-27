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
                            let dailyList = realm.objects(T.self)
                            realm.delete(dailyList)
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
    
    public func tipsPostList(completion: (() -> ())? = nil) {
        let realm = RealmProvider.shared.realm
        APIManager.getTipsPost(["": ""]).json()
            .subscribe(onNext: { json in
                do {
                    try realm.write {
                        for item in json.arrayValue {
                            let title = item["title"]["rendered"].stringValue
                            let picture = item["_embedded"]["wp:featuredmedia"]
                                .arrayValue.first?["media_details"]["sizes"]["full"]["source_url"].stringValue
                            let id = item["id"].stringValue
                            let category = item["categories"].arrayValue.last?.stringValue
                            let content =  item["content"]["rendered"].stringValue
                            realm.create(TipsPost.self, value: ["title": title,
                                                                "picture": picture,
                                                                "id": id,
                                                                "category": category,
                                                                "content": content], update: .modified)
                        }
                        Logger.info("TipsPost was create successfully")
                        completion?()
                    }
                } catch let error {
                    Logger.error("DataBase of Realm was changed \(error)")
                }
            }).disposed(by: disposeBag)
    }
}

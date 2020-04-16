//
//  MealsService.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation

class MealsService: RealmService<MealSceneModel> {
    
    private lazy var api_token = RealmProvider.shared.realm.objects(User.self).first?.api_token ?? ""
    
    public func getMealsList( completion: (() -> Void)? = nil) {
        APIManager.mealsList(["api_token": api_token]).json()
            .subscribe(onNext: { json in
                do {
                    let realm = RealmProvider.shared.realm
                    try realm.write {
                        let data = json["data"].arrayValue
                        if !data.isEmpty {
                            for program in data {
                                realm.create(T.self, value: program.object, update: .modified)
                            }
                            Logger.info("ProgramList was create successfully")
                        }
                    }
                    completion?()
                } catch let error {
                    Logger.error("DataBase of Realm was changed \(error)")
                }
            }).disposed(by: disposeBag)
    }
}

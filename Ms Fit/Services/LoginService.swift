//
//  LoginService.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation

class LoginService: RealmService<User> {
    
    public func register(goal: String,
                         activity: String,
                         birthday: String,
                         email: String,
                         password: String,
                         name: String,
                         ios_device_token: String,
                         completion: (() -> Void)? = nil) {
        APIManager.register(["goal": goal,
                          "activity": activity,
                          "birthday": birthday,
                          "email": email,
                          "password": password,
                          "name": name,
                          "ios_device_token": ios_device_token]).json()
            .subscribe(onNext: { json in
                do {
                    let realm = RealmProvider.shared.realm
                    try realm.write {
                        let data = json["data"]
                        if !data.isEmpty {
                               realm.create(T.self, value: data.object, update: .modified)
                               Logger.info("User was create successfully")
                           }
                       }
                       completion?()
                   } catch let error {
                       Logger.error("DataBase of Realm was changed \(error)")
                   }
               }).disposed(by: disposeBag)
       }
    
    public func login(email: String, password: String, completion: (() -> Void)? = nil) {
        APIManager.login(["email": email, "password": password]).json()
            .subscribe(onNext: { json in
                do {
                    let realm = RealmProvider.shared.realm
                    try realm.write {
                        let data = json["data"]
                        if !data.isEmpty {
                            realm.create(T.self, value: data.object, update: .modified)
                            Logger.info("User was create successfully")
                        }
                    }
                    completion?()
                } catch let error {
                    Logger.error("DataBase of Realm was changed \(error)")
                }
            }).disposed(by: disposeBag)
    }
}

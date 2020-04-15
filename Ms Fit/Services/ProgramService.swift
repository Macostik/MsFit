//
//  ProgramService.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 15.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation

class ProgramService: RealmService<Program> {
    
    private lazy var api_token = RealmProvider.shared.realm.objects(User.self).first?.api_token ?? ""
    
    public func getProgramList( completion: (() -> Void)? = nil) {
          APIManager.programList(["api_token": api_token]).json()
              .subscribe(onNext: { json in
                  do {
                    let realm = RealmProvider.shared.realm
                    try realm.write {
                        let data = json["data"].arrayValue
                        if !data.isEmpty {
                            for program in data {
                                realm.create(ProgramList.self, value: program.object, update: .modified)
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
    
    public func chooseProgram( completion: (() -> Void)? = nil) {
        APIManager.chooseProgram(["api_token": api_token, "program_id": "2", "level": "2"]).json()
            .subscribe(onNext: { json in
                do {
                    let realm = RealmProvider.shared.realm
                    try realm.write {
                        let data = json["data"]
                        if !data.isEmpty {
                            realm.create(T.self, value: data.object, update: .modified)
                            Logger.info("Program was create successfully")
                        }
                    }
                    completion?()
                } catch let error {
                    Logger.error("DataBase of Realm was changed \(error)")
                }
            }).disposed(by: disposeBag)
    }
}

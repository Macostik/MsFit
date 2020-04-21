//
//  ExercisesService.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 21.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation

class ExercisesService: RealmService<ExercisesModel> {
    
    public func getExerciseList( completion: (() -> Void)? = nil) {
           APIManager.exerciseList(["api_token": api_token]).json()
               .subscribe(onNext: { json in
                   do {
                       let realm = RealmProvider.shared.realm
                    try realm.write {
                        let data = json["data"]
                        if !data.isEmpty {
                            let today = data["today"]
                            realm.create(T.self, value: today.object, update: .modified)
                            let yesterday = data["yesterday"]
                            realm.create(T.self, value: yesterday.object, update: .modified)
                            let tomorrow = data["tomorrow"]
                            realm.create(T.self, value: tomorrow.object, update: .modified)
                            Logger.info("ExercisesList was create successfully")
                        }
                    }
                    completion?()
                   } catch let error {
                       Logger.error("DataBase of Realm was changed \(error)")
                   }
               }).disposed(by: disposeBag)
       }
}

//  
//  ExercisesSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift
import RxDataSources

final class ExercisesModel: Object {
    @objc dynamic public var ID = UUID().uuidString
    @objc dynamic public var id = 0
    @objc dynamic public var order = 0
    @objc dynamic public var created_at = ""
    @objc dynamic public var updated_at = ""
    let exercises = List<ExerciseItem>()
    
    override static func primaryKey() -> String? {
        return "ID"
    }
}

final class ExerciseItem: Object {
    @objc dynamic public var id = 0
    @objc dynamic public var title = ""
    @objc dynamic public var sets = 0
    @objc dynamic public var set_time: String?
    @objc dynamic public var total_time = ""
    let reps = RealmOptional<Int>()
    let pictures = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum ExercisesList: String, CaseIterable {
    case abs, arm, back, cardio, chest, legs, body, shoulder
}

struct ExercisesSceneModel {
    var items: [ExercisesList]
}

extension ExercisesSceneModel: SectionModelType {
    typealias Item = ExercisesList
    
    init(original: ExercisesSceneModel, items: [Item]) {
        self = original
        self.items = items
    }
}

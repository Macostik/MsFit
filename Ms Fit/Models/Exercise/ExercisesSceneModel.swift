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

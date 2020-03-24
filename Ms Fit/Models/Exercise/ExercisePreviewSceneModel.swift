//  
//  ExercisePreviewSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift
import RxDataSources

enum ExercisePreviewList: String, CaseIterable {
    case arm_rotations, push_ups, crunches, arm_circles, burpees, wall_sit, jumping_jacks, squats
    
    func description() -> String {
        switch self {
        case .arm_rotations:
            return "Triceps extension - both arms same time"
        case .push_ups:
            return "Biceps curls"
        case .crunches:
            return "Lying down butt kick"
        case .arm_circles:
            return "Arm circles"
        case .burpees:
            return "Lunges cressed weights"
        case .wall_sit:
            return "Squats side walk"
        case .jumping_jacks:
            return "Calf rise"
        case .squats:
            return "Water hydrant"
        }
    }
}

struct ExercisePreviewSceneModel {
    var items: [ExercisePreviewList]
}

extension ExercisePreviewSceneModel: SectionModelType {
    typealias Item = ExercisePreviewList
    
    init(original: ExercisePreviewSceneModel, items: [Item]) {
        self = original
        self.items = items
    }
}

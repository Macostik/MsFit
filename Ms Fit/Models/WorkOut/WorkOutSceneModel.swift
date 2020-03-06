//  
//  WorkOutSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift
import RxDataSources

enum YesterdayWorkoutList: String, CaseIterable {
    case arm_rotations, push_ups, crunches, arm_circles, burpees, wall_sit, jumping_jacks, squats
    
    func description() -> (String, String) {
        switch self {
        case .arm_rotations:
            return ("1. Arm rotations", "15min")
        case .push_ups:
            return ("2. Push-ups", "20 repeats/5 sets")
        case .crunches:
            return ("3. Crunches", "30 sec/4 sets")
        case .arm_circles:
            return ("4. Arm circles", "15 min")
        case .burpees:
            return ("5. Burpees", "5 sets/20 repeats")
        case .wall_sit:
            return ("6. Wall Sit", "15 min")
        case .jumping_jacks:
            return ("7. Jumping Jacks", "15 min")
        case .squats:
            return ("8. Squats", "5 sets/20 repeats")
        }
    }
}

struct YesterdayWorkoutSceneModel {
    var items: [YesterdayWorkoutList]
}

extension YesterdayWorkoutSceneModel: SectionModelType {
    typealias Item = YesterdayWorkoutList
    
    init(original: YesterdayWorkoutSceneModel, items: [Item]) {
        self = original
        self.items = items
    }
}

enum TodayWorkoutList: String, CaseIterable {
    case arm_rotations, push_ups, crunches, arm_circles
    
    func description() -> (String, String) {
        switch self {
        case .arm_rotations:
            return ("1. Arm rotations", "15min")
        case .push_ups:
            return ("2. Push-ups", "20 repeats/5 sets")
        case .crunches:
            return ("3. Crunches", "30 sec/4 sets")
        case .arm_circles:
            return ("4. Arm circles", "15 min")
        }
    }
}

struct TodayWorkoutSceneModel {
    var items: [TodayWorkoutList]
}

extension TodayWorkoutSceneModel: SectionModelType {
    typealias Item = TodayWorkoutList
    
    init(original: TodayWorkoutSceneModel, items: [Item]) {
        self = original
        self.items = items
    }
}

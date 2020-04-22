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

//struct YesterdayWorkoutList {
//    
//    static func exersices() -> [ExerciseItem]? {
//        let realm = RealmProvider.shared.realm
//        return realm.objects(ExercisesModel.self).first?.exercises.toArray()
//    }
//}
//
//struct YesterdayWorkoutSceneModel {
//    var items: [YesterdayWorkoutList]
//}
//
//extension YesterdayWorkoutSceneModel: SectionModelType {
//    typealias Item = YesterdayWorkoutList
//    
//    init(original: YesterdayWorkoutSceneModel, items: [Item]) {
//        self = original
//        self.items = items
//    }
//}
//
//enum TodayWorkoutList: String, CaseIterable {
//    case crunches, arm_circles
//    
//    func description() -> (String, String) {
//        switch self {
//        case .crunches:
//            return ("3. Crunches", "30 ثانية / 4 مجموعات")
//        case .arm_circles:
//            return ("4. Arm circles", "15 دقيقة")
//        }
//    }
//}
//
//struct TodayWorkoutSceneModel {
//    var items: [TodayWorkoutList]
//}
//
//extension TodayWorkoutSceneModel: SectionModelType {
//    typealias Item = TodayWorkoutList
//    
//    init(original: TodayWorkoutSceneModel, items: [Item]) {
//        self = original
//        self.items = items
//    }
//}
//
//enum TomorrowWorkoutList: String, CaseIterable {
//    case crunches, arm_circles, burpees, wall_sit, arm_rotations, push_ups
//    
//    func description() -> (String, String) {
//        switch self {
//        case .burpees:
//            return ("5. Burpees", "5 مجموعات / 20 تكرار")
//        case .wall_sit:
//            return ("6. Wall Sit", "15 دقيقة")
//        case .crunches:
//            return ("3. Crunches", "30 ثانية / 4 مجموعات")
//        case .arm_circles:
//            return ("4. Arm circles", "15 دقيقة")
//        case .arm_rotations:
//            return ("1. Arm rotations", "15 دقيقة")
//        case .push_ups:
//            return ("2. Push-ups", "20 تكرار / 5 مجموعات")
//        }
//    }
//}
//
//struct TomorrowWorkoutSceneModel {
//    var items: [TomorrowWorkoutList]
//}
//
//extension TomorrowWorkoutSceneModel: SectionModelType {
//    typealias Item = TomorrowWorkoutList
//    
//    init(original: TomorrowWorkoutSceneModel, items: [Item]) {
//        self = original
//        self.items = items
//    }
//}

//
//  Dependency.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import Foundation

class Dependency {
    let loginService = LoginService()
    let dailyService = DailyService()
    let programService = ProgramService()
    let mealsService = MealsService()
    let exercisesService = ExercisesService()
}

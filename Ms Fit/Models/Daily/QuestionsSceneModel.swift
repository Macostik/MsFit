//  
//  QuestionsSceneModel.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RealmSwift

enum QuestionMealModels: String, CaseIterable {
    case question1
    case question2
    case question3
    case question4
    case question5
    case question6
    case question7
    case question8
    case question9
    
    func description() -> (String, String) {
        switch self {
        case .question1:
            return ("How Is Leukemia Treated?",
                    "Committing to a longer subscription increases your success rate")
        case .question2:
            return ("Genital Warts How To Avoid Them",
                    "Committing to a longer subscription increases your success rate")
        case .question3:
            return ("Learn How To Motivate Yourself",
                    "Committing to a longer subscription increases your success rate")
        case .question4:
            return ("A Starter Guide To Self?",
                    "Committing to a longer subscription increases your success rate")
        case .question5:
            return ("Diabetes Cause And Prevention?",
                    "Committing to a longer subscription increases your success rate")
        case .question6:
            return ("This is how to perform one reoetition:",
                    "Committing to a longer subscription increases your success rate")
        case .question7:
            return ("Keep chest open and shoulders back",
                    "Committing to a longer subscription increases your success rate")
        case .question8:
            return ("Keeo core engaged",
                    "Committing to a longer subscription increases your success rate")
        case .question9:
            return ("Feet hip width apart",
                    "Committing to a longer subscription increases your success rate")
        }
    }
}

enum QuestionExerciseModels: String, CaseIterable {
    case question1
    case question2
    case question3
    case question4
    case question5
    case question6
    
    func description() -> (String, String) {
        switch self {
        case .question1:
            return ("Lorem ipsum dolor sit amet",
                    "Committing to a longer subscription increases your success rate")
        case .question2:
            return ("Ut enim ad minim veniam, quis nostrud",
                    "Committing to a longer subscription increases your success rate")
        case .question3:
            return ("Ullamco laboris nisi ut aliquip",
                    "Committing to a longer subscription increases your success rate")
        case .question4:
            return ("Duis aute irure dolor in reprehenderit",
                    "Committing to a longer subscription increases your success rate")
        case .question5:
            return ("Diabetes Cause And Prevention?",
                    "Committing to a longer subscription increases your success rate")
        case .question6:
            return ("This is how to perform one reoetition:",
                    "Committing to a longer subscription increases your success rate")
        }
    }
}

enum QuestionSubscriptionModels: String, CaseIterable {
    case question1
    case question2
    case question3
    case question4
    case question5
    
    func description() -> (String, String) {
        switch self {
        case .question1:
            return ("Ut labore et dolore magna aliqua. Ut enim ad?",
                    "Committing to a longer subscription increases your success rate")
        case .question2:
            return ("In voluptate velit esse cillum dolore eu",
                    "Committing to a longer subscription increases your success rate")
        case .question3:
            return ("Sed do eiusmod tempor incididunt ut labore et",
                    "Committing to a longer subscription increases your success rate")
        case .question4:
            return ("Officia deserunt mollit anim id est laborum.",
                    "Committing to a longer subscription increases your success rate")
        case .question5:
            return ("aliquip ex ea commodo consequat?",
                    "Committing to a longer subscription increases your success rate")
        }
    }
}

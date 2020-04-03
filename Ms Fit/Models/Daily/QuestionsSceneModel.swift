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
                    """
    Committing to a longer subscription increases your success rate, Committing to a longer subscription
    increases your success rate, Committing to a longer subscription increases your success rate,Committing to
    a longer subscription increases your success rate ,Committing to a longer subscription increases your
    success rate ,Committing to a longer subscription increases your success rate ,Committing to a longer
    subscription increases your success rate
    """)
        case .question2:
            return ("Genital Warts How To Avoid Them",
                    """
    The URL scheme is an interesting feature provided by the iOS SDK that allows developers to launch system
    apps and third-party apps through URLs. For example, let’s say your app displays a phone number, and you
    want to make a call whenever a user taps that number.
    """)
        case .question3:
            return ("Learn How To Motivate Yourself",
                    """
    You can use a specific URL scheme to launch the built-in phone app and dial the number automatically.
    Similarly, you can use another URL scheme to launch the Message app for sending an SMS. Additionally, you
    can create a custom URL scheme for your own app so that other applications can launch your app via a URL.
    You’ll see what I mean in a minute.
    """)
        case .question4:
            return ("A Starter Guide To Self?",
                    """
    As usual, we will build an app to demonstrate the use of URL schemes. We will reuse the QR code reader
    app that was built in the previous chapter. If you haven’t read the QR code tutorial, go back and read it
    before continuing on.
    """)
        case .question5:
            return ("Diabetes Cause And Prevention?",
                    """
    So far, the demo app is capable of decoding a QR code and displaying the decoded message on screen. In
    this chapter, we’ll make it even better. When the QR code is decoded, the app will launch the
    corresponding app based on the type of the URL.
    """)
        case .question6:
            return ("This is how to perform one reoetition:",
                    """
    Here I include some sample QR codes that you can use to test the app. Alternatively, you can create your
    QR code using online services like www.qrcode-monkey.com. Open the demo app and point your device’s
    camera at one of the codes. You should see the decoded message.
    """)
        case .question7:
            return ("Keep chest open and shoulders back",
                    "Committing to a longer subscription increases your success rate")
        case .question8:
            return ("Keeo core engaged",
                    """
    The launchApp method takes in a URL decoded from the QR code and creates an alert prompt. If the user taps
    the Confirm button, the app then creates an URL object and opens it accordingly. iOS will then open the
    corresponding app based on the given URL.
    
    In the metadataOutput method, which is called when a QR code is detected, insert a line of code to call
    the launchApp method:
    """)
        case .question9:
            return ("Feet hip width apart",
                    """
    These URLs are known as custom URL schemes created by third-party apps. For iOS 9 and later, the app is
    not able to open these custom URLs. Apple has made a small change to the handling of URL scheme,
    specifically for the canOpenURL() method. If the URL scheme is not registered in the whitelist, the method
    returns false. If you refer to the console messages, you should see the error like this:
    """)
        }
    }
}

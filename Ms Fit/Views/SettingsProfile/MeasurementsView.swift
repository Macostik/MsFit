//
//  MeasurementsView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class MeasurementsView: UIView {
    
    private let measurementsView = specify(UIView(), {
        $0.backgroundColor = .clear
    })
        
    private let measurementLabel = Label(icon: "Measurements",font: .systemFont(ofSize: 13, weight: .regular),
                                         size: 13, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        handleUI()
        addConstraints()
    }
    
    fileprivate func handleUI() {
        backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented MeasurementsView")
    }
}

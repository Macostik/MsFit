//
//  TimerPopupView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 07.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TimerPopupView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    private var viewModel: StartWorkoutSceneViewModel?
    
    public var baseVStackView: UIStackView!
    
    private let topSeparView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3411764706, blue: 0.8745098039, alpha: 1) })
    private let middleSeparView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3411764706, blue: 0.8745098039, alpha: 1) })
    
    public let contunieButton = specify(UIButton(type: .roundedRect), {
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.setTitle("متابعة", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
    })
    
    public let skipExerciseButton = specify(UIButton(type: .roundedRect), {
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.setTitle("تجاوز التمرين", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
    })
    
    public let restartExeciseButton = specify(UIButton(type: .roundedRect), {
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.setTitle("إعادة التمرين", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
    })
    
    public let endWorkoutButton = specify(UIButton(type: .roundedRect), {
        $0.backgroundColor = .systemBackground
        $0.setTitle("إنهاء التمرين", for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1), for: .normal)
    })
    
    init(with viewModel: StartWorkoutSceneViewModel?) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    fileprivate func setupUI() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8)
    }
    
    fileprivate func addConstraints() {
        contunieButton.heightAnchor.constraint(equalToConstant: Constants.sW * 0.2).isActive = true
        endWorkoutButton.heightAnchor.constraint(equalToConstant: Constants.sW * 0.25).isActive = true
        
        let buttonsVStackView = VStackView(arrangedSubviews: [
            contunieButton, skipExerciseButton, restartExeciseButton
        ])
        buttonsVStackView.distribution = .fillEqually
        
        baseVStackView = VStackView(arrangedSubviews: [ buttonsVStackView, endWorkoutButton ])
        
        add(baseVStackView, layoutBlock: { $0.leading().trailing().bottom() })
        contunieButton.add(topSeparView, layoutBlock: { $0.leading().trailing().bottom().height(1) })
        skipExerciseButton.add(middleSeparView, layoutBlock: { $0.leading().trailing().bottom().height(1) })
    }
    
    fileprivate func setupBindings() {
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

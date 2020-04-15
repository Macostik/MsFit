//  
//  RestWorkoutSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 08.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RestWorkoutSceneViewController: BaseViewController<RestWorkoutSceneViewModel> {
    
    private let progressTimerView = ProgressTimer()
    
    private let restLabel = specify(UILabel(), {
        $0.text = "راحة 😅"
        $0.font = .systemFont(ofSize: 40, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let isTimer = false
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    
    private let pauseConfiguration = UIImage.SymbolConfiguration(weight: .regular)
    internal lazy var pauseWorkoutBtn = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "pause.fill", withConfiguration: pauseConfiguration)?
            .withTintColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        $0.titleEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        $0.setTitle("وقفة", for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), for: .normal)
        $0.layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        $0.layer.borderWidth = 1.5
        $0.circled = true
    })
    
    private let nextWorkoutBtn = specify(UIButton(type: .roundedRect), {
        $0.setTitle("التالى", for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), for: .normal)
        $0.layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        $0.layer.borderWidth = 1.5
        $0.circled = true
    })
    
    private let nextLabel = specify(UILabel(), {
        $0.text = "التمرين التالي"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let nextExerciseLabel = specify(UILabel(), {
        $0.text = "دوران الذراع"
        $0.font = .systemFont(ofSize: 22, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        nextWorkoutBtn.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        progressTimerView.progressTimer.add(progressTimerView.basicAnimation, forKey: "urSoBasic")
        progressTimerView.toggleTimer(isOn: !isTimer)
    }
    
    fileprivate func addConstraints() {
        let buttonsHStackView = HStackView(arrangedSubviews: [pauseWorkoutBtn, nextWorkoutBtn], spacing: 40)
        buttonsHStackView.distribution = .fillEqually
        let nextVStackView = VStackView(arrangedSubviews: [nextLabel, nextExerciseLabel], spacing: 16)
        
        view.add(progressTimerView, layoutBlock: {
            $0.centerX().centerY(-25).size(Constants.sH_812 ? Constants.sW * 0.6 : Constants.sH_667 ?
                Constants.sW * 0.5 : Constants.sW * 0.4) })
        view.add(restLabel, layoutBlock: { $0.bottomTop(-25, to: progressTimerView).centerX() })
        view.add(buttonsHStackView, layoutBlock: {
            $0.bottom(25).leading(20).trailing(20).height(Constants.sW * 0.15)
        })
        view.add(nextVStackView, layoutBlock: {
            $0.bottomTop(-40, to: buttonsHStackView).leading(16).trailing(16)
        })
        view.add(separatorView, layoutBlock: {
            $0.bottomTop(-30, to: nextVStackView).leading(16).trailing(16).height(1)
        })
    }
}

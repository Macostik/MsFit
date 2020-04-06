//  
//  StartWorkoutSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StartWorkoutSceneViewController: BaseViewController<StartWorkoutSceneViewModel> {
    
    private let basicContainerView = ProgressTimer()
    
    private let startConfiguration = UIImage.SymbolConfiguration(weight: .thin)
    internal lazy var startWorkoutButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "play.fill", withConfiguration: startConfiguration)?
            .withTintColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
        $0.setTitle("Start", for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), for: .normal)
        $0.layer.borderColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        $0.layer.borderWidth = 1
        $0.circled = true
    })
    
    private let topSeparator = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    private let bottomSeparator = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    
    private let exerciseLabel = specify(UILabel(), {
        $0.text = "2. Spot jogging"
        $0.font = .systemFont(ofSize: 22, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        startWorkoutButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                UIView.animate(withDuration: 0.3) {
                    self.startWorkoutButton.setImage(UIImage(systemName: "pause.fill",
                                                             withConfiguration: self.startConfiguration)?
                        .withTintColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
                    self.startWorkoutButton.setTitle("Pause", for: .normal)
                }
                self.basicContainerView.progressTimer.add(self.basicContainerView.basicAnimation,
                                                          forKey: "urSoBasic")
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        topSeparator.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        bottomSeparator.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        view.add(startWorkoutButton, layoutBlock: {
            $0.bottom(Constants.sH_812 ? 30 : 15).centerX()
                .width(Constants.sW * 0.4).height(Constants.sW * 0.15)
        })
        view.add(basicContainerView, layoutBlock: {
            $0.bottomTop(-25, to: startWorkoutButton)
                .size(Constants.sH_812 ? Constants.sW * 0.5 : Constants.sW * 0.4).centerX()
        })
        
        let exerciseVStackView = VStackView(arrangedSubviews: [topSeparator, exerciseLabel, bottomSeparator],
                                            spacing: 30)
        view.add(exerciseVStackView, layoutBlock: {
            $0.bottomTop(-25, to: basicContainerView).leading(16).trailing(16).centerX()
        })
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
}

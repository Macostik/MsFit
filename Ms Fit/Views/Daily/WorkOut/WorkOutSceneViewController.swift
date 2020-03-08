//  
//  WorkOutSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WorkOutSceneViewController: BaseViewController<WorkOutSceneViewModel> {
    
    private let workoutSegmentView = WorkoutSegmentView()
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let navWorkoutLabel = specify(UILabel(), {
        $0.text = "Workout"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
        DispatchQueue.main.async {
            self.workoutSegmentView.slideCollection.selectItem(at: IndexPath(row: 1, section: 0),
                                                               animated: false,
                                                               scrollPosition: .centeredHorizontally)
        }
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navWorkoutLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navWorkoutLabel).leading(4).size(44) })
        view.add(workoutSegmentView, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing().bottom()
        })
    }
}

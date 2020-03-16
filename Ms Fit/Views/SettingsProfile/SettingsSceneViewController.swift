//  
//  SettingsSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsSceneViewController: BaseViewController<SettingsSceneViewModel> {
    
    private let userView = UserView()
    private let graphView = GraphView()
    private let measurementsView = MeasurementsView()
    
    private let scrollView = specify(UIScrollView(), {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    fileprivate func addConstraints() {
        let vBaseStackView = VStackView(arrangedSubviews: [userView, graphView, measurementsView])
        
        view.add(scrollView, layoutBlock: { $0.top().width(Constants.sW).bottom(tabBarHeight) })
        scrollView.add(vBaseStackView, layoutBlock: {
            $0.top().bottom().width(Constants.sW)
        })
    }
}

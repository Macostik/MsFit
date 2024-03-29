//  
//  AllVideosSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AllVideosSceneViewController: BaseViewController<AllVideosSceneViewModel> {
    
    private let videoSlideSegmentControl = VideosSlideSegmentControll()
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
    })
    
    private let navVideosLabel = specify(UILabel(), {
        $0.text = "جميع التمارين"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navVideosLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 8) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navVideosLabel).leading(4).size(44) })
        view.add(videoSlideSegmentControl, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing().bottom()
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

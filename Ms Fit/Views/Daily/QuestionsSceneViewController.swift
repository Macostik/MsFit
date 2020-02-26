//  
//  QuestionsSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class QuestionsSceneViewController: BaseViewController<QuestionsSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let navQuestionsLabel = specify(UILabel(), {
        $0.text = "Questions"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let hQuestionViewsStackView = specify(UIStackView(), {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
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
        view.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.9800000191, blue: 0.9800000191, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
        
        let labelsList = questionsList.map({ [unowned self] title in self.createTFView(title: title) })
        labelsList.forEach({ [unowned self] view in self.hQuestionViewsStackView.addArrangedSubview(view) })
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : 80)
        })
        navigationView.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 40 : 20).leading(4).size(44)
        })
        navigationView.add(navQuestionsLabel, layoutBlock: { $0.centerX().bottom(15) })
        view.add(hQuestionViewsStackView, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing().height(50)
        })
    }
    
    private let questionsList = ["Meals", "Exercises", "Subcriptions"]
    
    fileprivate func createTFView(title: String) -> UIView {
        let view = UIView()
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemBackground
        view.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        view.add(label, layoutBlock: { $0.center() })
        return view
    }
}

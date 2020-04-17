//  
//  GeneralProgramSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 17.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GeneralProgramSceneViewController: BaseViewController<GeneralProgramSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let navigationView = specify(UIView(), { $0.backgroundColor = .clear })
    
    private let navLabel = specify(UILabel(), {
        $0.text = "البرنامج العام"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let beginner1Button = specify(UIButton(type: .roundedRect), {
        $0.circled = true
        $0.setTitle("Beginner 1", for: .normal)
        $0.tintColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.backgroundColor = .systemBackground
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
    })
    
    private let beginner2Button = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        $0.backgroundColor = .systemBackground
        $0.setTitle("Beginner 2", for: .normal)
        $0.circled = true
        $0.tintColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let intermediate1Button = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        $0.backgroundColor = .systemBackground
        $0.setTitle("Intermediate 1", for: .normal)
        $0.circled = true
        $0.tintColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let intermediate2Button = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        $0.backgroundColor = .systemBackground
        $0.setTitle("Intermediate 2", for: .normal)
        $0.circled = true
        $0.tintColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
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
        
        beginner1Button.animateWhenPressed(disposeBag: disposeBag)
        beginner1Button.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                print("beginner1Button")
            }).disposed(by: disposeBag)
        
        beginner2Button.animateWhenPressed(disposeBag: disposeBag)
        beginner2Button.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                print("beginner2Button")
            }).disposed(by: disposeBag)
        
        intermediate1Button.animateWhenPressed(disposeBag: disposeBag)
        intermediate1Button.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                print("intermediate1Button")
            }).disposed(by: disposeBag)
        
        intermediate2Button.animateWhenPressed(disposeBag: disposeBag)
        intermediate2Button.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                print("intermediate2Button")
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        beginner1Button.heightAnchor.constraint(equalToConstant: Constants.sW * 0.3).isActive = true
        
        let vButtonsStackView = VStackView(arrangedSubviews: [
            beginner1Button, beginner2Button, intermediate1Button, intermediate2Button
        ], spacing: 25)
        vButtonsStackView.distribution = .fillEqually
        
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navLabel, layoutBlock: { $0.centerX().bottom() })
        navigationView.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).leading(4).size(44)
        })
        
        view.add(vButtonsStackView, layoutBlock: { $0.centerX().centerY(50).width(Constants.sW - 40) })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

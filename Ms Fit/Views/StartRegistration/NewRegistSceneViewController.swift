//  
//  NewRegistSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewRegistSceneViewController: BaseViewController<NewRegistSceneViewModel> {
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(UIColor(named: "closeButton")!, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let datePicker = specify(UIDatePicker(), {
        let date = NSDate()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year], from: date as Date)
        let startOfMonth = calendar.date(from: components)
        $0.setDate(startOfMonth!, animated: true)
        $0.transform = CGAffineTransform(scaleX: -1, y: 1)
        $0.isHidden = true
    })
    
    private let goalImageView = specify(UIImageView(), {
        $0.image = #imageLiteral(resourceName: "start_goal_icon")
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let verStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.spacing = 20
    })
    
    private let verForButtonStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.spacing = 30
        $0.distribution = .fillEqually
    })
    
    private let quetionLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        $0.text = "What is your goal?"
    })
    
    private let bottomLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.text = "طالبة"
        $0.textAlignment = .center
        $0.textColor = UIColor(named: "placeholderTextFieldColor")
    })
    
    private let progressView = specify(UIProgressView(), {
        $0.progress = 0.0
        $0.progressTintColor = UIColor(named: "magentaColor")
        $0.layer.cornerRadius = 8/2
        $0.clipsToBounds = true
        $0.layer.sublayers![1].cornerRadius = 8/2
        $0.subviews[1].clipsToBounds = true
    })
    
    private let loseWeightButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(UIColor(named: "textButtonColor"), for: .normal)
        $0.customButton(text: "Lose Weight", font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1), bgColor: .systemBackground)
    })
    
    private let maintainWeightButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(UIColor(named: "textButtonColor"), for: .normal)
        $0.customButton(text: "Maintain Weight", font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1), bgColor: .systemBackground)
    })
    
    private let gainWeightButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(UIColor(named: "textButtonColor"), for: .normal)
        $0.customButton(text: "Gain Weight", font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1), bgColor: .systemBackground)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObservable)
            .disposed(by: disposeBag)
        
        loseWeightButton.animateWhenPressed(disposeBag: disposeBag)
        loseWeightButton.rx.tap
            .subscribe(onNext: { _ in
                //do something
            }).disposed(by: disposeBag)
        
        maintainWeightButton.animateWhenPressed(disposeBag: disposeBag)
        maintainWeightButton.rx.tap
            .subscribe(onNext: { _ in
                //do something
            }).disposed(by: disposeBag)
        
        gainWeightButton.animateWhenPressed(disposeBag: disposeBag)
        gainWeightButton.rx.tap.map({ _ in false })
            .subscribe(onNext: { [weak self] flag in
                self?.verForButtonStackView.isHidden = !flag
                self?.datePicker.isHidden = flag
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = .systemBackground
        bottomLabel.frame(forAlignmentRect: CGRect.init(x: 0, y: -30, width: 0, height: 0))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3, animations: {
                self.progressView.setProgress(0.2, animated: true)
            })
        }
    }
    
    fileprivate func addConstraints() {
        view.add(closeButton, layoutBlock: {
            $0.top(Constants.screenHeight812 ? 40 : 20).leading(6).size(44)
        })
        view.add(goalImageView, layoutBlock: {
            $0.top(Constants.screenHeight812 ? 100 : 30).centerX()
                .width(Constants.screenWidth / 4.7).height(Constants.screenWidth / 4)
        })
        progressView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        loseWeightButton.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 8).isActive = true
        verForButtonStackView.addArrangedSubview(loseWeightButton)
        verForButtonStackView.addArrangedSubview(maintainWeightButton)
        verForButtonStackView.addArrangedSubview(gainWeightButton)
        verStackView.addArrangedSubview(quetionLabel)
        verStackView.addArrangedSubview(progressView)
        view.add(verStackView, layoutBlock: { $0.centerX().topBottom(30, to: goalImageView) })
        view.add(verForButtonStackView, layoutBlock: {
            $0.leading(20).trailing(20).topBottom(Constants.screenWidth / 8, to: verStackView)
        })
        view.add(bottomLabel, layoutBlock: { $0.centerX().bottom(10)})
        view.sendSubviewToBack(datePicker, layoutBlock: {
            $0.leading().trailing().bottom(30, to: bottomLabel).height(250) })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}

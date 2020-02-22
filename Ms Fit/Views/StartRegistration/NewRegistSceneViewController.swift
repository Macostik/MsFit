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
    
    private let pickerView = specify(UIPickerView(), {
        $0.transform = CGAffineTransform(scaleX: -1, y: 1)
        $0.isHidden = true
    })
    internal var pickerElement = PickerData.weight
    
    private let goalImageView = specify(UIImageView(), {
        $0.image = #imageLiteral(resourceName: "start_goal_icon")
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let verStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.spacing = 30
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
        $0.textColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1) 
    })
    
    private let progressView = specify(UIProgressView(), {
        $0.progress = 0.0
        $0.progressTintColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.layer.cornerRadius = 8/2
        $0.clipsToBounds = true
        $0.layer.sublayers![1].cornerRadius = 8/2
        $0.subviews[1].clipsToBounds = true
    })
    
    private let loseWeightButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(#colorLiteral(red: 0.4670000076, green: 0.3219999969, blue: 0.851000011, alpha: 1), for: .normal)
        $0.customButton(text: "Lose Weight", font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1), bgColor: .systemBackground)
    })
    
    private let maintainWeightButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(#colorLiteral(red: 0.4670000076, green: 0.3219999969, blue: 0.851000011, alpha: 1), for: .normal)
        $0.customButton(text: "Maintain Weight", font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1), bgColor: .systemBackground)
    })
    
    private let gainWeightButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(#colorLiteral(red: 0.4670000076, green: 0.3219999969, blue: 0.851000011, alpha: 1), for: .normal)
        $0.customButton(text: "Gain Weight", font: 20, weight: .regular,
                        shadowColor: #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1), bgColor: .systemBackground)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
        setupPicker()
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
        gainWeightButton.rx.tap
            .map({ _ in false })
            .subscribe(onNext: { [weak self] flag in
                self?.verForButtonStackView.isHidden = !flag
                self?.pickerView.isHidden = flag
                self?.bottomLabel.isHidden = !flag
                UIView.animate(withDuration: 0.3, animations: {
                    self?.progressView.setProgress(0.4, animated: true)
                })
            }).disposed(by: disposeBag)
    }
    
    private func setupPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
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
        view.add(closeButton, layoutBlock: { $0.top(Constants.sH_812 ? 40 : 20).leading(4).size(44) })
        view.add(goalImageView, layoutBlock: {
            $0.top(Constants.sH_812 ? 100 : 30).centerX()
                .width(Constants.sW / 4.7).height(Constants.sW / 4)
        })
        progressView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        loseWeightButton.heightAnchor.constraint(equalToConstant: Constants.sH / 9).isActive = true
        verForButtonStackView.addArrangedSubview(loseWeightButton)
        verForButtonStackView.addArrangedSubview(maintainWeightButton)
        verForButtonStackView.addArrangedSubview(gainWeightButton)
        verStackView.addArrangedSubview(quetionLabel)
        verStackView.addArrangedSubview(progressView)
        view.add(verStackView, layoutBlock: { $0.centerX().topBottom(30, to: goalImageView) })
        view.add(bottomLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_812 ? 70 : 30) })
        view.add(verForButtonStackView, layoutBlock: {
            $0.leading(16).trailing(16).bottomTop(Constants.sH_812 ? -40 : -20, to: bottomLabel)
        })
        view.add(bottomLabel, layoutBlock: { $0.centerX().bottom(10)})
        view.sendSubviewToBack(pickerView, layoutBlock: {
            $0.leading().trailing().bottom(30, to: bottomLabel).height(250) })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}

typealias PickerListEntry = [[String]]
enum PickerData {
    case weight
    case age
    case height
    
    func dataList() -> PickerListEntry {
        switch self {
        case .weight:
            return [Array(35...140).map({"\($0)"}), Array(0...9).map({"\($0)"})]
        case .height:
            return [Array(130...200).map({"\($0)"})]
        case .age:
            return [Array(1900...2200).map({"\($0)"}),
                    Calendar.current.monthSymbols,
                    Array(1...31).map({"\($0)"})]
        }
    }
}

extension NewRegistSceneViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerElement.dataList().count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerElement.dataList()[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let weight = pickerElement.dataList()[component].max(by: {$1.count > $0.count})?.toString()
        .size(withAttributes: [.font: UIFont.systemFont(ofSize: 28.0)]).width ?? 70
        return weight < 60 ? weight + 100 : weight
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return component != 0 ? pickerElement == .weight ?
            ".\(pickerElement.dataList()[component][row]) kg" :
            "\(pickerElement.dataList()[component][row])" :
        "\(pickerElement.dataList()[component][row])"
    }
}

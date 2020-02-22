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
    private lazy var backButton = specify(UIButton(type: .roundedRect), {
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
    
    private let nextButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.customButton(text: "Next Step", font: 20, weight: .bold, shadowColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), bgColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1))
    })
    
    private let bottomLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: Constants.sH_812 ? 18 : 16, weight: .regular)
        $0.text = "بل بيل ب يل يبي بل"
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
    
    private let nextStepButton = specify(UIButton(type: .roundedRect), {
           $0.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
           $0.customButton(text: "next step", font: 17, weight: .regular,
                           shadowColor: #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1), bgColor: #colorLiteral(red: 0.4670000076, green: 0.3219999969, blue: 0.851000011, alpha: 1))
       })
    
    override func setupUI() {
        handleUI()
        addConstraints()
        setupPicker()
    }
    
    override func setupBindings() {
        backButton.rx.tap
            .map({ _ in })
            .subscribe(onNext: { [unowned self] in
                if self.pickerElement == .weight {
                    self.viewModel?.dismissObservable.onNext(())
                } else {
                    let item = self.pickerElement.previousElement()
                    self.pickerElement = item.0
                    self.goalImageView.image = item.1
                    self.quetionLabel.text = item.2
                    self.pickerView.reloadAllComponents()
                    UIView.animate(withDuration: 0.5) {
                        self.progressView
                            .setProgress(self.progressView.progress - 0.2,
                                                            animated: true)
                    }
                }
            }).disposed(by: disposeBag)
        
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
                self?.nextButton.isHidden = flag
                self?.goalImageView.isHidden = !flag
                self?.goalImageView.transform = CGAffineTransform(translationX: 100, y: 0)
                UIView.animate(withDuration: 0.5, animations: {
                    self?.goalImageView.image = #imageLiteral(resourceName: "start_weight_icon")
                    self?.goalImageView.transform = .identity
                    self?.quetionLabel.text = "What`s you weight?"
                    self?.goalImageView.isHidden = flag
                    self?.progressView.setProgress(0.4, animated: true)
                })
            }).disposed(by: disposeBag)
        
        nextButton.animateWhenPressed(disposeBag: disposeBag)
        nextButton.rx.tap
            .map({ _ in false })
            .subscribe(onNext: { [unowned self] flag in
                let item = self.pickerElement.nextElement()
                self.pickerElement = item.0
                self.pickerView.reloadAllComponents()
                self.goalImageView.transform = CGAffineTransform(translationX: 100, y: 0)
                UIView.animate(withDuration: 0.5, animations: {
                    self.goalImageView.image = item.1
                    self.goalImageView.transform = .identity
                    self.quetionLabel.text = item.2
                    self.goalImageView.isHidden = flag
                    self.progressView
                        .setProgress(self.progressView.progress + 0.2,
                                     animated: true)
                })
            }).disposed(by: disposeBag)
    }
    
    private var index = 0
    
    private func setupPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = .systemBackground
        nextButton.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3, animations: {
                self.progressView.setProgress(0.2, animated: true)
            })
        }
    }
    
    fileprivate func addConstraints() {
        view.add(backButton, layoutBlock: { $0.top(Constants.sH_812 ? 40 : 20).leading(4).size(44) })
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
        view.add(nextButton, layoutBlock: {
            $0.centerX().bottom(30).leading(16).trailing(16).height(Constants.sW / 5.5)
        })
        view.sendSubviewToBack(pickerView, layoutBlock: {
            $0.trailing(-20).leading().bottom(Constants.sH_812 ? 140 : 100, to: nextButton) })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}

typealias PickerListEntryType = [[String]]
typealias PickerCollectionType = (PickerData, UIImage, String)
enum PickerData: CaseIterable {
    case weight
    case height
    case age
    
    func dataList() -> PickerListEntryType {
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
    
    func nextElement() -> PickerCollectionType {
        switch self {
        case .weight:
            return (.height, #imageLiteral(resourceName: "start_height_icon"), "What is your height?")
        case .height, .age:
            return (.age, #imageLiteral(resourceName: "start_birthday_icon"), "Your birthday date?")
        }
    }
    func previousElement() -> PickerCollectionType {
        switch self {
        case .weight, .height:
            return (.weight, #imageLiteral(resourceName: "start_weight_icon"), "What`s you weight?")
        case .age:
            return (.height, #imageLiteral(resourceName: "start_height_icon"), "What is your height?")
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
        return weight < 60 ? weight + 45 : weight
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return pickerElement == .height && component == 0  ?
            "\(pickerElement.dataList()[component][row]) cm" :
            pickerElement == .weight && component != 0 ?
                ".\(pickerElement.dataList()[component][row]) kg" :
        "\(pickerElement.dataList()[component][row])"
    }
}

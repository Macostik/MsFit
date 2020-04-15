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
    
    public var pickerElement = PickerData.weight
    public var showOneScene = false
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var backButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(UIColor(named: "closeButton")!, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    public let pickerView = specify(UIPickerView(), {
        $0.transform = CGAffineTransform(scaleX: -1, y: 1)
        $0.isHidden = true
    })
    
    private let goalImageView = specify(UIImageView(), {
        $0.image = #imageLiteral(resourceName: "start_goal_icon")
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    public let verForButtonStackView = specify(UIStackView(), {
        $0.axis = .vertical
        $0.spacing = Constants.sH_667 ? 30 : 20
        $0.distribution = .fill
    })
    
    private let quetionLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.textAlignment = .center
        $0.text = "هدفك ؟"
    })
    
    private let nextButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.customButton(text: "التالي", font: 20, weight: .bold, shadowColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), bgColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1))
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
    
    private let buttonsTitle = ["خسارة وزن", "لياقة مع ثبات وزن", "زيادة وزن", "طالبة"]
    private var buttonList = [UIButton]()
    
    private let nextStepButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        $0.customButton(text: "التالي", font: 17, weight: .regular, shadowColor: #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1), bgColor: #colorLiteral(red: 0.4670000076, green: 0.3219999969, blue: 0.851000011, alpha: 1))
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
                if self.showOneScene {
                    self.viewModel?.dismissObservable.onNext(())
                } else if !self.verForButtonStackView.isHidden &&
                    (self.buttonList.last?.isHidden ?? false) {
                    self.viewModel?.dismissObservable.onNext(())
                } else {
                    let flag = self.pickerElement == .weight
                    self.buttonList.last?.isHidden = true
                    self.verForButtonStackView.isHidden = !flag
                    self.bottomLabel.isHidden = !flag
                    self.nextButton.isHidden = flag
                    self.pickerView.isHidden = flag
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
        
        var type = "goal"
        let buttonTapIndex = buttonList.enumerated().map { ($0.0, $0.1.rx.tap) }
        let indexTap = buttonTapIndex.map { index, obs in obs.map { index } }
         Observable.merge(indexTap)
            .map({ index in (index, false) })
            .subscribe(onNext: { [weak self] index, flag in
                self?.viewModel?.parameters[type] = "\(index + 1)"
                type = "activity"
                if self?.pickerElement == .completed {
                    self?.viewModel?.presentSignUpObserver.onNext(())
                    return
                }
                self?.verForButtonStackView.isHidden = !flag
                self?.pickerView.isHidden = flag
                self?.bottomLabel.isHidden = !flag
                self?.nextButton.isHidden = flag
                self?.goalImageView.isHidden = !flag
                self?.goalImageView.transform = CGAffineTransform(translationX: 100, y: 0)
                UIView.animate(withDuration: 0.5, animations: {
                    self?.goalImageView.image = #imageLiteral(resourceName: "start_weight_icon")
                    self?.goalImageView.transform = .identity
                    self?.quetionLabel.text = "وزنك ؟"
                    self?.goalImageView.isHidden = flag
                    self?.progressView.setProgress(0.4, animated: true)
                })
            }).disposed(by: disposeBag)
        
        nextButton.animateWhenPressed(disposeBag: disposeBag)
        nextButton.rx.tap
            .map({ _ in false })
            .subscribe(onNext: { [unowned self] flag in
                let isEnd = self.pickerElement == .age
                self.verForButtonStackView.isHidden = !isEnd
                self.buttonList.last?.isHidden = !isEnd
                self.nextButton.isHidden = isEnd
                self.pickerView.isHidden = isEnd
                let item = self.pickerElement.nextElement()
                var selectedElement = ""
                switch self.pickerElement {
                case .height:
                    let selectedFirstIndex = self.pickerView.selectedRow(inComponent: 0)
                    selectedElement = self.pickerElement.dataList().first?[selectedFirstIndex] ?? ""
                case .weight:
                    let selectedFirstIndex = self.pickerView.selectedRow(inComponent: 0)
                    let selectedSecondIndex = self.pickerView.selectedRow(inComponent: 1)
                    selectedElement = "\(self.pickerElement.dataList()[0][selectedFirstIndex])" +
                    "\(self.pickerElement.dataList()[1][selectedSecondIndex])"
                case .age:
                    let selectedFirstIndex = self.pickerView.selectedRow(inComponent: 0)
                    let selectedSecondIndex = self.pickerView.selectedRow(inComponent: 1)
                    let selectedThirdIndex = self.pickerView.selectedRow(inComponent: 2)
                    let monthString = "\(self.pickerElement.dataList()[1][selectedSecondIndex])"
                    let month = Calendar.current.monthSymbols.firstIndex(of: monthString) ?? 0
                    let monthValue = month < 10 ? "0" + "\(month)" : "\(month)"
                    let dateString = "\(self.pickerElement.dataList()[2][selectedThirdIndex])"
                    let dateValue = dateString.count < 2 ? "0" + dateString : dateString
                    selectedElement = "\(self.pickerElement.dataList()[0][selectedFirstIndex])-" +
                    monthValue + "-" + dateValue
                default: break
                }
                self.viewModel?.parameters[self.pickerElement.rawValue] = selectedElement
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
    
    private func createButton(with title: String) -> UIButton {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.setTitleColor(#colorLiteral(red: 0.4670000076, green: 0.3219999969, blue: 0.851000011, alpha: 1), for: .normal)
        button.customButton(text: title , font: 20, weight: .regular,
                            shadowColor: #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1), bgColor: .systemBackground)
        return button
    }
    
    private func setupPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        nextButton.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3, animations: {
                self.progressView.setProgress(0.2, animated: true)
            })
        }
        buttonList = buttonsTitle.map({[unowned self] in
            let button = self.createButton(with: $0)
            button.animateWhenPressed(disposeBag: disposeBag)
            button.heightAnchor.constraint(equalToConstant: Constants.sH / 9).isActive = true
            return button
        })
        buttonList.last?.isHidden = true
    }
    
    fileprivate func addConstraints() {
        let verStackView = VStackView(arrangedSubviews: [quetionLabel, progressView], spacing: 30)
        
        view.add(backButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 50 : Constants.sH_667 ? 30 : 20).leading(4).size(44)
        })
        view.add(goalImageView, layoutBlock: {
            $0.top(Constants.sH_812 ? 100 : 30).centerX()
                .width(Constants.sW / 4.7).height(Constants.sW / 4)
        })
        
        progressView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 210).isActive = true
        
        buttonList.forEach({[weak self] in self?.verForButtonStackView.addArrangedSubview($0) })
        
        verForButtonStackView.addArrangedSubview(bottomLabel)
        view.add(verStackView, layoutBlock: {
            $0.centerX().topBottom(Constants.sH_667 ? 30 : 10, to: goalImageView)
        })
        view.add(verForButtonStackView, layoutBlock: { $0.leading(16).trailing(16).bottom(30) })
        view.add(nextButton, layoutBlock: {
            $0.centerX().bottom(30).leading(16).trailing(16).height(Constants.sW / 6.5)
        })
        view.sendSubviewToBack(pickerView, layoutBlock: {
            $0.trailing(-20).leading().height(250)
                .bottom(Constants.sH_812 ? 140 : Constants.sH_667 ? 100 : 60, to: nextButton) })
    }
}

typealias PickerListEntryType = [[String]]
typealias PickerCollectionType = (PickerData, UIImage, String)

enum PickerData: String, CaseIterable {
    case weight
    case height
    case age
    case completed
    
    func dataList() -> PickerListEntryType {
        switch self {
        case .weight:
            return [Array(35...140).map({"\($0)"}), Array(0...9).map({".\($0) kg"})]
        case .height:
            return [Array(130...200).map({"\($0) cm"})]
        case .age:
            return [Array(1960...2200).map({"\($0)"}),
                    Calendar.current.monthSymbols,
                    Array(1...31).map({"\($0)"})]
        case .completed:
            return [[""]]
        }
    }
    
    func nextElement() -> PickerCollectionType {
        switch self {
        case .weight:
            return (.height, #imageLiteral(resourceName: "start_height_icon"), "طولك ؟")
        case .height:
            return (.age, #imageLiteral(resourceName: "start_birthday_icon"), "تاريخ ميلادك ؟")
        case .age, .completed:
            return (.completed, #imageLiteral(resourceName: "start_activity_icon"), "مستوى نشاطك اليومي ؟")
        }
    }
    func previousElement() -> PickerCollectionType {
        switch self {
        case .weight, .height:
            return (.weight, #imageLiteral(resourceName: "start_weight_icon"), "وزنك ؟")
        case .age:
            return (.height, #imageLiteral(resourceName: "start_height_icon"), "طولك ؟")
        case .completed:
            return (.age, #imageLiteral(resourceName: "start_birthday_icon"), "تاريخ ميلادك ؟")
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
            .size(withAttributes: [.font: UIFont.systemFont(ofSize: 34.0)]).width ?? 70
        return weight
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return "\(pickerElement.dataList()[component][row])"
    }
}

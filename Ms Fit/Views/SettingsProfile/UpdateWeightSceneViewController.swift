//  
//  UpdateWeightSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 01.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UpdateWeightSceneViewController: BaseViewController<UpdateWeightSceneViewModel> {
    
    private let pickerElement = WeightPickerData.weight
    private let pickerView = UIPickerView()
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = .clear
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "تحديث الوزن"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let updateButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "حفظ", font: 20, weight: .bold,
                        shadowColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), bgColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), isCircled: true)
    })
    
    private let weightImageView = specify(UIImageView(), {
        $0.image = #imageLiteral(resourceName: "start_weight_icon")
        $0.contentMode = .scaleAspectFit
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
        
        updateButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        view.add(updateButton, layoutBlock: {
            $0.bottom(Constants.sH_812 ? 30 : 20).leading(16).trailing(16).height(Constants.sW / 6)
        })
        view.add(weightImageView, layoutBlock: {
            $0.topBottom(30, to: navigationView).centerX()
                .width(Constants.sW * 0.4).height(Constants.sW * 0.5)
        })
        view.add(pickerView, layoutBlock: { $0.centerY(100).centerX() })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 8) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navTextLabel).leading(4).size(44)})
    }
}

extension UpdateWeightSceneViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerElement.dataList().count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerElement.dataList()[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let weight = pickerElement.dataList()[component].max(by: {$1.count > $0.count})?.toString()
            .size(withAttributes: [.font: UIFont.systemFont(ofSize: 50.0)]).width ?? 70
        return weight
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return "\(pickerElement.dataList()[component][row])"
    }
}

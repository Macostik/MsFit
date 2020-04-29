//
//  MeasurementsView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MeasurementsView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    private var viewModel: SettingsSceneViewModel?
    
    private let containerView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let topSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1) })
    private let bottomSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1) })
    
    private let measurementLabel = specify(UILabel(), {
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.text = "قياسات"
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
    })
    
    private let tableView = specify(UITableView(), {
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.isScrollEnabled = false
        $0.rowHeight = Constants.sH_812 ? 70 : 60
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.register(SettingUpdateCell.self, forCellReuseIdentifier: SettingUpdateCell.identifier)
    })
    
    public let updateMeasureButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.setTitle("تسجيل القياسات", for: .normal)
        $0.layer.shadowColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.layer.cornerRadius = (Constants.sW / 5.5) / 2
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = .init(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    })
    
    init(with viewModel: SettingsSceneViewModel?) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        handleUI()
        addConstraints()
        setupBindings()
    }
    
    fileprivate func handleUI() {
        backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    }
    
    fileprivate func setupBindings() {
        Observable.just(UpdateMeasurementModel.allCases).bind(to: tableView.rx.items(cellIdentifier:
            SettingUpdateCell.identifier, cellType: SettingUpdateCell.self)) { _, model, cell in
                cell.setup(model)
                cell.accessoryType = .disclosureIndicator
        }.disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(UpdateMeasurementModel.self))
            .bind { indexPath, model in
                self.viewModel?.presentHistoryExerciseObserver.onNext((indexPath.row, model.rawValue))
        }.disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        add(measurementLabel, layoutBlock: { $0.trailing(16).top(30) })
        add(tableView, layoutBlock: { $0.top(60).leading().trailing().height(Constants.sH_812 ? 280 : 240) })
        add(topSeparatorView, layoutBlock: {$0.bottomTop(to: tableView).leading().trailing().height(1) })
        add(containerView, layoutBlock: { $0.topBottom(to: tableView).leading().trailing() })
        containerView.add(bottomSeparatorView, layoutBlock: {$0.bottom().trailing().leading().height(1) })
        containerView.add(updateMeasureButton, layoutBlock: {
            $0.width(Constants.sW - 32).height(Constants.sW / 5.5).centerX().bottom(20).top(20)
        })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

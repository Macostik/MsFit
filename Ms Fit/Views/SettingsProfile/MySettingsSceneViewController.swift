//  
//  MySettingsSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

typealias SettingsDataSource = RxTableViewSectionedReloadDataSource<SectionOfSettings>

class MySettingsSceneViewController: BaseViewController<MySettingsSceneViewModel> {
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "Settings"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        return tableView
    }()
    
    internal lazy var dataSource = {
           return SettingsDataSource(configureCell: { _, tableView, indexPath, item in
               guard let cell = tableView
                   .dequeueReusableCell(withIdentifier: SettingsCell.identifier,
                                        for: indexPath) as? SettingsCell else { fatalError() }
               cell.setup(setting: item)
               return cell
           })
       }()
    
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
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.just(SettingsStorageData.allCases.map({ $0.description() }))
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SettingsStorageSceneModel.self)
        .subscribe(onNext: { [weak self] model in
            self?.viewModel?.heightSceneObserver.onNext(())
        }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navTextLabel).leading(4).size(44) })
        view.add(tableView, layoutBlock: { $0.leading().trailing().topBottom(to: navigationView).bottom() })
    }
}

extension MySettingsSceneViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SettingsHeaderView()
        let title = dataSource.sectionModels[section].header
        header.setup(title: title)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 3 ? 10 : 30
    }
}

class SettingsCell: UITableViewCell, CellIdentifierable {
    
    let tosSwitch = specify(UISwitch(), {
        $0.isOn = true
    })
    let accessoryLabel = UILabel()
    
    func setup(setting: SettingsStorageSceneModel) {
        textLabel?.text = setting.description().0
        add(accessoryLabel, layoutBlock: { $0.centerY().trailing(40) })
        accessoryLabel.text = setting.description().1
        if setting == .logOut {
            textLabel?.textAlignment = .center
            textLabel?.textColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1)
        } else if setting == .termOfUse {
            add(tosSwitch, layoutBlock: { $0.centerY().trailing(20) })
        } else {
            accessoryType = .disclosureIndicator
        }
    }
}

class SettingsHeaderView: UIView {
    
    let titleLabel = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 13.0)
    })
    
    public func setup(title: String) {
        add(titleLabel, layoutBlock: { $0.leading(16).bottom(5) })
        titleLabel.text = title
    }
}

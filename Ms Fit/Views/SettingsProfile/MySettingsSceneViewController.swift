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
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        return tableView
    }()
    
    internal lazy var dataSource = {
           return SettingsDataSource(configureCell: { _, tableView, indexPath, item in
               guard let cell = tableView
                   .dequeueReusableCell(withIdentifier: SettingsCell.identifier,
                                        for: indexPath) as? SettingsCell else { fatalError() }
               cell.setup(profile: item)
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
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navTextLabel).leading(4).size(44)})
        view.add(tableView, layoutBlock: {$0.leading().trailing().topBottom(to: navigationView).bottom()})
    }
}

extension MySettingsSceneViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileHeaderView()
        let title = dataSource.sectionModels[section].header
        header.setup(title: title)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 10 : 20
    }
}

class SettingsCell: UITableViewCell, CellIdentifierable {
    
    let profileSwitch = specify(UISwitch(), {
        $0.onTintColor = #colorLiteral(red: 0.5098039216, green: 0.368627451, blue: 0.7137254902, alpha: 1)
    })
    
    func setup(profile: SettingsStorageSceneModel) {
        textLabel?.text = profile.description().0
        textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        textLabel?.textColor = #colorLiteral(red: 0.2823529412, green: 0.2431372549, blue: 0.4470588235, alpha: 1)
        if profile.description().1 {
            add(profileSwitch, layoutBlock: { $0.trailing(20).centerY() })
        } else {
            accessoryType = .disclosureIndicator
        }
    }
}

class SettingsHeaderView: UIView {
    
    let titleLabel = specify(UILabel(), {
        $0.font = UIFont.boldSystemFont(ofSize: 13.0)
        $0.textColor = #colorLiteral(red: 0.5098039216, green: 0.368627451, blue: 0.7137254902, alpha: 1)
    })
    
    public func setup(title: String) {
        add(titleLabel, layoutBlock: { $0.leading(16).bottom(5) })
        titleLabel.text = title
    }
}

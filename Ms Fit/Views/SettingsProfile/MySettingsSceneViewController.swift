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
        $0.text = "الإعدادات"
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
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
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
                switch model {
                case .weight:
                    print("tap weight")
                case .heigth:
                    print("tap heigth")
                case .dateOfBirthday:
                    print("tap dateOfBirthday")
                case .goal:
                    self?.viewModel?.heightSceneObserver.onNext(model)
                case .activity:
                    print("tap activity")
                case .selectionLevel:
                    self?.viewModel?.presentLevelSelectionObserver.onNext(())
                case .accountSettings:
                    self?.viewModel?.presentAccountSettingsObserver.onNext(())
                case .accountType:
                    self?.viewModel?.presentAccountTypeObserver.onNext(())
                case .contactUs:
                    self?.viewModel?.presentContactUsObserver.onNext(())
                case .aboutApp:
                    print("tap aboutApp")
                case .privacyPolicy:
                    self?.viewModel?.presentPrivacyPolicyObserver.onNext(())
                case .termOfUse:
                    self?.viewModel?.presentTermOfUseObserver.onNext(())
                case .notification:
                    break
                case .version:
                    break
                case .logOut:
                print("tap logOut")
                }
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 8) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navTextLabel).leading(4).size(44) })
        view.add(tableView, layoutBlock: { $0.leading().trailing().topBottom(to: navigationView).bottom() })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
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

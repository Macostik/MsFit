//
//  ProfileSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileSceneViewController: BaseViewController<ProfileSceneViewModel> {
    
    private let tableView = specify(UITableView(), {
        $0.backgroundColor = .systemBackground
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GraphCell.self, forCellReuseIdentifier: GraphCell.reuseId)
        tableView.showsVerticalScrollIndicator = false
    }
    
    fileprivate func addConstraints() {
        view.add(tableView, layoutBlock: { $0.top().leading().trailing().bottom(tabBarHeight - 20) })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}

extension ProfileSceneViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let graphCell = tableView.dequeueReusableCell(withIdentifier: GraphCell.reuseId,
                                                      for: indexPath) as! GraphCell

        return graphCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView()
    }
}

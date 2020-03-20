//
//  TipsMenuView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 17.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TipsMenuView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    public var heightConstraints: NSLayoutConstraint!
    
    public let menuTableView = specify(UITableView(), {
        $0.backgroundColor = .systemBackground
        $0.rowHeight = Constants.sW * 0.9 / 5
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.isScrollEnabled = false
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.register(TipsMenuCell.self, forCellReuseIdentifier: TipsMenuCell.identifier)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    func setupUI() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8)
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    func setupBindings() {
        Observable.just(TipsMenuModel.allCases).bind(to: menuTableView.rx.items(cellIdentifier:
            TipsMenuCell.identifier, cellType: TipsMenuCell.self)) { _, model, cell in
                cell.setup(model)
        }.disposed(by: disposeBag)
        
    }
    
    func addConstraints() {
        heightConstraints = menuTableView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraints.isActive = true
        
        add(menuTableView, layoutBlock: { $0.top().leading().trailing() })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

//
//  SubjectMenuTableView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SubjectMenuTableView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    private let menuItems =
              ["5 - أخرى" ,"4 - الحساب" ,"3 - تجريب" ,"2 - المدفوعات", "1 - تسجيل الدخول / الاشتراك"]
    public var heightConstraints: NSLayoutConstraint!
    
    private let selectSubjectLabel = Label(icon: "اختر موضوعا",
                                           font: .systemFont(ofSize: 13, weight: .regular),
                                           textColor: #colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1), isTranform: false, textAlignment: .right)
    public let selectedItemLabel = Label(icon: "المدفوعات", font: .systemFont(ofSize: 18, weight: .regular),
                                          textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: false)
    
    private let dropDownImage = specify(UIImageView(), {
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)
    })
    
    private let topSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    private let bottomSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    
    public let menuTableView = specify(UITableView(), {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(SubjectMenuCell.self, forCellReuseIdentifier: SubjectMenuCell.identifier)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    func setupUI() {
        backgroundColor = .clear
    }
    
    func setupBindings() {
        Observable.just(menuItems).bind(to: menuTableView.rx.items(cellIdentifier:
            SubjectMenuCell.identifier, cellType: SubjectMenuCell.self)) { _, model, cell in
                cell.setup(model)
        }.disposed(by: disposeBag)
        
    }
    
    func addConstraints() {
        heightConstraints = menuTableView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraints.isActive = true
        
        let vSubStackView = VStackView(arrangedSubviews: [selectSubjectLabel, selectedItemLabel],
                                           spacing: 10)
        
        add(vSubStackView, layoutBlock: { $0.leading().top(10) })
        add(dropDownImage, layoutBlock: {  $0.trailing().top(25) })
        add(topSeparatorView, layoutBlock: {
            $0.topBottom(6, to: vSubStackView).leading().trailing().height(1)
        })
        add(menuTableView, layoutBlock: { $0.topBottom(to: topSeparatorView).leading().bottom().trailing() })
        add(bottomSeparatorView, layoutBlock: { $0.leading().trailing().bottom().height(1) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

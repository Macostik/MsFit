//
//  AddPopupView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 12.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AddPopupView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    public let containerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        $0.clipsToBounds = true
    })
    
    public let addButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "أضف", font: 20, weight: .bold,
                        shadowColor: .clear, bgColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), isCircled: false)
    })
    
    private let tableView = specify(UITableView(), {
        $0.backgroundColor = .systemBackground
        $0.showsVerticalScrollIndicator = false
        $0.allowsMultipleSelection = true
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(LunchCell.self, forCellReuseIdentifier: LunchCell.identifier)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    fileprivate func setupUI() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.8)
    }
    
    fileprivate func addConstraints() {
        
        add(containerView, layoutBlock: {
            $0.bottom().leading().trailing().height(Constants.sH_812 ? 340 : 325)
        })
        containerView.add(addButton, layoutBlock: {
            $0.bottom().leading().trailing().height(Constants.sH_812 ? 80 : 60)
        })
        containerView.add(tableView, layoutBlock: { $0.top().leading().trailing().bottomTop(to: addButton) })
        containerView.transform = CGAffineTransform(translationX: 0, y: self.containerView.height)
    }
    
    fileprivate func setupBindings() {
        addButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                UIView.animate(withDuration: 0.4, delay: 0, animations: {
                    self.containerView.transform = CGAffineTransform(translationX: 0,
                                                                     y: self.containerView.height)
                }, completion: { _ in
                    self.isHidden = true
                })
            }).disposed(by: disposeBag)
        
        Observable.just(LunchList.allCases)
            .bind(to: tableView.rx.items(cellIdentifier: LunchCell.identifier,
                                         cellType: LunchCell.self)) { _, data, cell in
                                            cell.setup(data)
        }.disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

class LunchCell: UITableViewCell, CellIdentifierable {
    
    private let iconImageView = specify(UIImageView(), {
        $0.contentMode = .scaleAspectFit
    })
    
    private let dietTextLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    public let checkmarkButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "chackmark_icon"), for: .normal)
        $0.tintColor = .systemBackground
        $0.isUserInteractionEnabled = false
        $0.layer.borderColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 32 / 2
        $0.clipsToBounds = true
    })
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addConstraints()
    }
    
    public func setup(_ entry: LunchList) {
        iconImageView.image = UIImage(named: entry.rawValue)
        dietTextLabel.text = entry.description()
    }
    
    fileprivate func setupUI() {
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkmarkButton.backgroundColor = selected ? #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    fileprivate func addConstraints() {
        let hStackView = HStackView(arrangedSubviews: [iconImageView, dietTextLabel], spacing: 8)
        
        add(hStackView, layoutBlock: { $0.leading(16).top(16).bottom(16) })
        add(checkmarkButton, layoutBlock: { $0.trailing(16).centerY().size(32) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

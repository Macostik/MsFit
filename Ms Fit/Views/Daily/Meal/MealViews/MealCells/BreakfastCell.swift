//
//  BreakfastCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import FSPagerView
import RxSwift
import RxCocoa

class BreakfastCell: UICollectionViewCell, FSPagerViewDataSource, FSPagerViewDelegate, CellIdentifierable {
    
    private let pagerView = FSPagerView()
    public var tapHalper: (() -> Void)?
    public var cellTapHalper: ((Int) -> Void)?
    
    private let iconImageView = specify(UIImageView(), {
        $0.image = UIImage(named: "Breakfast")
        $0.contentMode = .scaleAspectFit
    })
    
    private let breakfastLabel = specify(UILabel(), {
        $0.text = "Breakfast"
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    })
    
    public func setup(_ entry: Int) {
        setupUI()
        addConstraint()
    }
    
    fileprivate func setupUI() {
        pagerView.transformer = PagerViewTransformer(type: .coverFlow)
        pagerView.register(BreakfastPagerCell.self, forCellWithReuseIdentifier: BreakfastPagerCell.identifier)
        pagerView.backgroundColor = .systemBackground
        pagerView.itemSize = CGSize(width: Constants.sW - 120, height: Constants.sH * 0.47)
        pagerView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.isInfinite = true
        pagerView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    fileprivate func addConstraint() {
        iconImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        let hStackView = HStackView(arrangedSubviews: [iconImageView, breakfastLabel], spacing: 10)
        
        add(hStackView, layoutBlock: { $0.top().centerX(-10) })
        add(pagerView, layoutBlock: { $0.topBottom(to: hStackView).leading().bottom().trailing() })
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return BreakfastList.allCases.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: BreakfastPagerCell.identifier,
                                                 at: index) as! BreakfastPagerCell
        let entry = BreakfastList.allCases[index]
        cell.setup(entry: entry)
        cell.tapHalper = tapHalper
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        cellTapHalper?(index)
    }
}

//
//  PreviewImagePagerView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 13.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import FSPagerView

class PreviewImagePagerView: FSPagerView {
    
    private let pageControl = specify(FSPageControl(), {
        $0.contentHorizontalAlignment = .center
    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addConstraints()
    }
        
    fileprivate func setupUI() {
        dataSource = self
        delegate = self
        isInfinite = true
        register(PreviewImageCell.self, forCellWithReuseIdentifier: PreviewImageCell.identifier)
        pageControl.interitemSpacing = 10
        pageControl.numberOfPages = DetailsImageList.allCases.count
        pageControl.setFillColor(UIColor.systemBackground.withAlphaComponent(0.3), for: .normal)
        pageControl.setFillColor(UIColor.systemBackground, for: .selected)
        pageControl.setPath(.init(ovalIn: .init(x: -1, y: -0.6, width: 8, height: 8)), for: .selected)
        pageControl.setPath(.init(ovalIn: .init(x: 0, y: 0, width: 7, height: 7)), for: .normal)
    }
    
    fileprivate func addConstraints() {
        add(pageControl, layoutBlock: { $0.bottom(20).centerX() })
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
}

extension PreviewImagePagerView: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return DetailsImageList.allCases.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: PreviewImageCell.identifier,
                                                 at: index) as! PreviewImageCell
        let entry = DetailsImageList.allCases[index]
        cell.setup(entry: entry)
        return cell
    }
}

extension PreviewImagePagerView: FSPagerViewDelegate {
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }
}

class PreviewImageCell: FSPagerViewCell {
    
    static let identifier = "PreviewImageCell"
    
    private let previewImageView = specify(UIImageView(), {
        $0.contentMode = .scaleToFill
    })
    
    public func setup(entry: DetailsImageList) {
        add(previewImageView, layoutBlock: { $0.edges() })
        previewImageView.image = UIImage(named: entry.rawValue)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
}

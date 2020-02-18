//  
//  OnboardSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FSPagerView

class OnboardSceneViewController: BaseViewController<OnboardSceneViewModel> {
    
    private let pagerView = FSPagerView()
    public let pageControl: FSPageControl = {
        let page = FSPageControl()
        page.contentHorizontalAlignment = .center
        return page
    }()
    
    override func setupUI() {
        view.backgroundColor = .systemBackground
        
        pagerView.dataSource = self
        //        pagerView.itemSize = UIScreen.main.bounds
        pagerView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        pageControl.numberOfPages = ImageList.allCases.count
        pageControl.setStrokeColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        pageControl.setFillColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .selected)
        pageControl.setAlpha(alpha: 0.5, animated: true)
        view.add(pagerView, layoutBlock: { $0.edges() })
        view.add(pageControl, layoutBlock: { $0.width(100).height(30).centerX().bottom(130)})
    }
    
    override func setupBindings() {
        //        viewModel?.indicatorViewAnimating.drive(<#drive#>),
        //        viewModel?.elements.drive(<#drive#>),
        //        viewModel?.loadError.drive(onNext: {<#drive#>}),
    }
}

extension OnboardSceneViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return ImageList.allCases.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier,
                                                 at: index) as! ImageCell
        let entry = ImageList.allCases[index].rawValue
        cell.setup(entry: entry)
        return cell
    }
}

class ImageCell: FSPagerViewCell {
    
    static let identifier = "ImageCell"
    
    let splashImageView = specify(UIImageView(), {
        $0.contentMode = .scaleToFill
    })
    
    public func setup(entry: String) {
        add(splashImageView, layoutBlock: { $0.edges() })
        splashImageView.image = UIImage(named: entry)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
}

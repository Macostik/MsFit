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
    
    public let pageControl = specify(FSPageControl(), {
        $0.contentHorizontalAlignment = .center
    })
    
    private var startButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.setTitle("ابدئي", for: .normal)
        $0.layer.shadowColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.layer.cornerRadius = (Constants.sW / 5.5) / 2
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = .init(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    })
    
    private let signInButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        $0.setTitle("دخول الأعضاء", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    })
    
    override func setupUI() {
        addPagerVeiw()
        addConstraints()
    }
    
    override func setupBindings() {
        startButton.animateWhenPressed(disposeBag: disposeBag)
        startButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel?.presentNewRegistObservable.onNext(())
            }).disposed(by: disposeBag)
        
        signInButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel?.signInObserver.onNext(())
            }).disposed(by: disposeBag)
    }
}

extension OnboardSceneViewController {
    
    fileprivate func addPagerVeiw() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        pagerView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        pageControl.interitemSpacing = 15
        pagerView.bounces = false
        pageControl.numberOfPages = ImageList.allCases.count
        pageControl.setFillColor(UIColor.systemBackground.withAlphaComponent(0.3), for: .normal)
        pageControl.setFillColor(UIColor.systemBackground, for: .selected)
        pageControl.setPath(.init(ovalIn: .init(x: -1, y: -2, width: 12, height: 12)), for: .selected)
        pageControl.setPath(.init(ovalIn: .init(x: 0, y: 0, width: 8, height: 8)), for: .normal)
    }
    
    fileprivate func addConstraints() {
        let verticalStackView = VStackView(arrangedSubviews: [startButton, signInButton], spacing: 10)
        
        startButton.heightAnchor.constraint(equalToConstant: Constants.sW / 5.5).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.add(pagerView, layoutBlock: { $0.edges() })
        pagerView.add(verticalStackView, layoutBlock: {
            $0.bottom(Constants.sH_812 ? 20 : 0).leading(16).trailing(16)
        })
        pagerView.add(pageControl, layoutBlock: { $0.centerX(-5).bottom(Constants.sH / 3.9) })
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
}

extension OnboardSceneViewController: FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return ImageList.allCases.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier,
                                                 at: index) as! ImageCell
        let entry = ImageList.allCases[index]
        cell.setup(entry: entry)
        return cell
    }
}

extension OnboardSceneViewController: FSPagerViewDelegate {
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }
}

class ImageCell: FSPagerViewCell {
    
    static let identifier = "ImageCell"
    
    private let splashImageView = specify(UIImageView(), {
        $0.contentMode = .scaleToFill
    })
    
    private let topLabel = specify(UILabel(), {
        $0.textColor = UIColor.systemBackground
        $0.font = .boldSystemFont(ofSize: 22)
    })
    
    private let bottomLabel = specify(UILabel(), {
        $0.setLineHeight("", lineHeight: 5.0)
        $0.textColor = UIColor.systemBackground
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    })
    
    public func setup(entry: ImageList) {
        let verticalStackView = VStackView(arrangedSubviews: [topLabel, bottomLabel], spacing: 10)
        verticalStackView.alignment = .center
        verticalStackView.axis = .vertical
        
        add(splashImageView, layoutBlock: {
            $0.top().leading().trailing().bottom(Constants.sH / 4.7)
        })
        splashImageView.add(verticalStackView, layoutBlock: {
            $0.leading(50).trailing(50).bottom(Constants.sH_812 ? 80 : 50)
        })
        splashImageView.image = UIImage(named: entry.rawValue)
        topLabel.text = entry.description().0
        bottomLabel.text = entry.description().1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
}

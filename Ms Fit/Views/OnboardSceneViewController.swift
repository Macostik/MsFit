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
    private var startButton = UIButton(type: .roundedRect)
    public let pageControl = specify(FSPageControl(), {
        $0.contentHorizontalAlignment = .center
    })
    
    private let signInButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.setTitle("Login", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    })
    
    private let verticalStackView = specify(UIStackView(), {
        $0.axis = .vertical
    })
    
    override func setupUI() {
        addPagerVeiw()
        addConstraints()
    }
    
    override func setupBindings() {
        startButton.rx.tap
            .subscribe(onNext: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.startButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }) { complition in
                    self.startButton.transform = .identity
                }
            }).disposed(by: disposeBag)
        
        signInButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel?.signInObserver.onNext(())
            }).disposed(by: disposeBag)
    }
}

extension OnboardSceneViewController {
    
    fileprivate func addPagerVeiw() {
        view.backgroundColor = .systemBackground
        pagerView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        startButton.customButton(text: "Start", cornerR: 64/2, font: 20, weight: .bold,
                                 shadowColor: UIColor(named: "purpleColor1")!, bgColor: UIColor(named: "purpleColor1")!)
        pagerView.dataSource = self
        pagerView.delegate = self
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
        verticalStackView.addArrangedSubview(startButton)
        verticalStackView.addArrangedSubview(signInButton)
        startButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        view.add(pagerView, layoutBlock: { $0.edges() })
        pagerView.add(verticalStackView, layoutBlock: { $0.bottom(14).leading(16).trailing(16) })
        pagerView.add(pageControl, layoutBlock: { $0.centerX(-5).bottomTop(-45, to: verticalStackView) })
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
        $0.text = "Activity Program"
        $0.textColor = UIColor.systemBackground
        $0.font = UIFont.boldSystemFont(ofSize: 34)
    })
    
    private let bottomLabel = specify(UILabel(), {
        $0.setLineHeight("Be the girl who decided decided \ndecided to go for it!", lineHeight: 5.0)
        $0.textColor = UIColor.systemBackground
        $0.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    })
    
    private let verticalStackView = specify(UIStackView(), {
        $0.spacing = 10
        $0.alignment = .center
        $0.axis = .vertical
    })
    
    public func setup(entry: ImageList) {
        add(splashImageView, layoutBlock: { $0.top().leading().trailing().bottom(140) })
        verticalStackView.addArrangedSubview(topLabel)
        verticalStackView.addArrangedSubview(bottomLabel)
        splashImageView.add(verticalStackView, layoutBlock: { $0.leading(50).trailing(50).bottom(80) })
        splashImageView.image = UIImage(named: entry.rawValue)
        topLabel.text = entry.description()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
}


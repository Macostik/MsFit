//
//  HistoryGraphView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 25.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class HistoryGraphView: UIView {
    
    private let topSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1) })
    private let bottomSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1) })
    private let nowLeftSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    private let nowRightSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    private let separatorView = specify(UIView(), {$0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    private let lostContainerView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let standartContainerView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let nowContainerView = specify(UIView(), {  $0.backgroundColor = .systemBackground })
    private let graphContainerView = specify(UIView(), { $0.backgroundColor = .systemGray2 })
    
    private let lostTextLabel = specify(UILabel(), {
        $0.text = "LOST"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let lostResultLabel = specify(UILabel(), {
        $0.text = "-4.3"
        $0.font = .systemFont(ofSize: 24, weight: .regular)
    })
    
    private let lostKGLabel = specify(UILabel(), {
        $0.text = "kg"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    })
    
    private let nowTextLabel = specify(UILabel(), {
        $0.text = "NOW"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let nowResultLabel = specify(UILabel(), {
        $0.text = "84.3"
        $0.font = .systemFont(ofSize: 24, weight: .regular)
    })
    
    private let nowKGLabel = specify(UILabel(), {
        $0.text = "kg"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    })
    
    private let standartTextLabel = specify(UILabel(), {
        $0.text = "STANDART"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let standartResultLabel = specify(UILabel(), {
        $0.text = "80.1"
        $0.font = .systemFont(ofSize: 24, weight: .regular)
    })
    
    private let standartKGLabel = specify(UILabel(), {
        $0.text = "kg"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addconstraints()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .systemBackground
    }
    
    fileprivate func addconstraints() {
        
        let hLostResultStackView = HStackView(arrangedSubviews: [lostResultLabel, lostKGLabel])
        let vLostStackView = VStackView(arrangedSubviews: [lostTextLabel, hLostResultStackView], spacing: 4)
        
        let hNowResultStackView = HStackView(arrangedSubviews: [nowResultLabel, nowKGLabel])
        let vNowStackView = VStackView(arrangedSubviews: [nowTextLabel, hNowResultStackView], spacing: 4)
        let hStandartResultStackView = HStackView(arrangedSubviews: [standartResultLabel, standartKGLabel])
        let vStandartStackView = VStackView(arrangedSubviews: [standartTextLabel, hStandartResultStackView],
                                            spacing: 4)
        let hBaseReusltStackView =
            HStackView(arrangedSubviews: [lostContainerView, nowContainerView, standartContainerView])
        hBaseReusltStackView.distribution = .fillEqually
        hBaseReusltStackView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        lostContainerView.add(vLostStackView, layoutBlock: { $0.center() })
        nowContainerView.add(nowLeftSeparatorView, layoutBlock: { $0.leading().top(5).bottom(5).width(1) })
        nowContainerView.add(nowRightSeparatorView, layoutBlock: { $0.trailing().top(5).bottom(5).width(1) })
        nowContainerView.add(vNowStackView, layoutBlock: { $0.center() })
        standartContainerView.add(vStandartStackView, layoutBlock: { $0.center() })
        add(hBaseReusltStackView, layoutBlock: { $0.leading().trailing().height(80).top() })
        hBaseReusltStackView.add(separatorView, layoutBlock: { $0.bottom().leading().trailing().height(1) })
        add(graphContainerView, layoutBlock: {
            $0.topBottom(to: hBaseReusltStackView).leading().trailing().height(300).bottom()
        })
        add(topSeparatorView, layoutBlock: { $0.top().leading().trailing().height(1) })
        add(bottomSeparatorView, layoutBlock: { $0.bottom().leading().trailing().height(1) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
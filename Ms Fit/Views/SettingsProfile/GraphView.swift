//
//  GraphView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    private let lostContainerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
    })
    
    private let lostTextLabel = specify(UILabel(), {
        $0.text = "LOST"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let separatorView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
    })
    
    private let lostResultLabel = specify(UILabel(), {
        $0.text = "-4.3"
        $0.font = .systemFont(ofSize: 24, weight: .regular)
    })
    
    private let lostKGLabel = specify(UILabel(), {
        $0.text = "kg"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    })
    
    private let nowLeftSeparatorView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1)
    })
    
    private let nowRightSeparatorView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1)
    })
    
    private let nowContainerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
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
    
    private let standartContainerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
    })
    
    private let standartResultLabel = specify(UILabel(), {
        $0.text = "80.1"
        $0.font = .systemFont(ofSize: 24, weight: .regular)
    })
    
    private let standartKGLabel = specify(UILabel(), {
        $0.text = "kg"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    })
    
    private let graphContainerView = specify(UIView(), {
        $0.backgroundColor = .systemGray2
    })
    
    private let updateWeightButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.setTitle("Update Weight", for: .normal)
        $0.layer.shadowColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.layer.cornerRadius = (Constants.sW / 5.5) / 2
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = .init(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    })
    
    private let historyButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(#colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), for: .normal)
        $0.customButton(text: "History", font: 16, weight: .regular, shadowColor: .clear)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addconstraints()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .systemBackground
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    fileprivate func addconstraints() {
        let vForButtonsStackView = VStackView(arrangedSubviews: [updateWeightButton, historyButton])
        vForButtonsStackView.distribution = .fillEqually
        
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
        
        lostContainerView.add(vLostStackView, layoutBlock: { $0.center() })
        nowContainerView.add(nowLeftSeparatorView, layoutBlock: { $0.leading().top(5).bottom(5).width(1) })
        nowContainerView.add(nowRightSeparatorView, layoutBlock: { $0.trailing().top(5).bottom(5).width(1) })
        nowContainerView.add(vNowStackView, layoutBlock: { $0.center() })
        standartContainerView.add(vStandartStackView, layoutBlock: { $0.center() })
        add(hBaseReusltStackView, layoutBlock: { $0.leading().trailing().height(80).top() })
        hBaseReusltStackView.add(separatorView, layoutBlock: { $0.bottom().leading().trailing().height(1) })
        add(graphContainerView, layoutBlock: {
            $0.topBottom(to: hBaseReusltStackView).leading().trailing().height(300)
        })
        updateWeightButton.heightAnchor.constraint(equalToConstant: Constants.sW / 5.5).isActive = true
        add(vForButtonsStackView, layoutBlock: {
            $0.topBottom(30, to: graphContainerView).leading(16).trailing(16).bottom()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented GraphView")
    }
}

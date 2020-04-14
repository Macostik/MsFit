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
    private let graphContainerView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    
    private let lostTextLabel = specify(UILabel(), {
        $0.text = "خسر"
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
        $0.text = "الان"
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
        $0.text = "المعيار"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.textAlignment = .center
    })
    
    private let standartResultLabel = specify(UILabel(), {
        $0.text = "2120.1"
        $0.font = .systemFont(ofSize: 24, weight: .regular)
    })
    
    private let standartKGLabel = specify(UILabel(), {
        $0.text = "kg"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGraph()
        addconstraints()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .systemBackground
    }
    
    fileprivate func addconstraints() {
        let vLostStackView = VStackView(arrangedSubviews: [lostTextLabel, lostResultLabel], spacing: 4)
        let vNowStackView = VStackView(arrangedSubviews: [nowTextLabel, nowResultLabel], spacing: 4)
        let vStandartStackView = VStackView(arrangedSubviews: [standartTextLabel, standartResultLabel],
                                            spacing: 4)
        let hBaseReusltStackView =
            HStackView(arrangedSubviews: [lostContainerView, nowContainerView, standartContainerView])
        hBaseReusltStackView.distribution = .fillEqually
        hBaseReusltStackView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        lostContainerView.add(vLostStackView, layoutBlock: { $0.center() })
        lostContainerView.add(lostKGLabel, layoutBlock: {
            $0.leadingTrailing(to: lostTextLabel).bottom(3, to: vLostStackView)
        })
        nowContainerView.add(nowLeftSeparatorView, layoutBlock: { $0.leading().top(5).bottom(5).width(1) })
        nowContainerView.add(nowRightSeparatorView, layoutBlock: { $0.trailing().top(5).bottom(5).width(1) })
        nowContainerView.add(vNowStackView, layoutBlock: { $0.center() })
        nowContainerView.add(nowKGLabel, layoutBlock: {
            $0.leadingTrailing(to: nowTextLabel).bottom(3, to: vNowStackView)
        })
        standartContainerView.add(vStandartStackView, layoutBlock: { $0.center() })
        standartContainerView.add(standartKGLabel, layoutBlock: {
            $0.leadingTrailing(to: standartTextLabel).bottom(3, to: vStandartStackView)
        })
        
        add(hBaseReusltStackView, layoutBlock: { $0.leading().trailing().height(80).top() })
        hBaseReusltStackView.add(separatorView, layoutBlock: { $0.bottom().leading().trailing().height(1) })
        add(graphContainerView, layoutBlock: {
            $0.topBottom(to: hBaseReusltStackView).leading().trailing().height(300).bottom()
        })
        add(topSeparatorView, layoutBlock: { $0.top().leading().trailing().height(1) })
        add(bottomSeparatorView, layoutBlock: { $0.bottom().leading().trailing().height(1) })
    }
    
    private func setupGraph() {
        let graphView = PNLineChart(frame: CGRect(x: 0, y: 0, width: Constants.sW, height: 250))
        graphView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        graphView.yLabelFormat = "%1.1f"
        graphView.showLabel = true
        graphView.backgroundColor = UIColor.clear
        graphView.xLabels = ["Jun 23", "Jun 25", "July 1", "Sep 4", "Sep 10", "Nov 22"]
        graphView.showCoordinateAxis = true
        graphView.axisColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)

        let dataArr = [145, 110.4, 108.2, 80.2, 60.6, 70.9]
        let data = PNLineChartData()
        data.color = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        data.lineWidth = 1
        data.itemCount = dataArr.count
        data.inflexPointStyle = .Cycle
        data.inflexionPointWidth = 10
        data.getData = ({
            (index: Int) -> PNLineChartDataItem in
            let yValue = CGFloat(dataArr[index])
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        graphView.chartData = [data]
        graphView.strokeChart()
        graphContainerView.add(graphView, layoutBlock: { $0.top(25).leading().trailing().bottom() })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

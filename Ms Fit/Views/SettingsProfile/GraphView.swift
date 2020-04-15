//
//  GraphView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    private let topSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1) })
    private let bottomSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1) })
    private let nowLeftSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    private let nowRightSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    private let separatorView = specify(UIView(), {$0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    private let lostContainerView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let standartContainerView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let nowContainerView = specify(UIView(), {  $0.backgroundColor = .systemBackground })
    private let graphContainerView = specify(UIView(), { $0.backgroundColor = .white })
    
    private let lostTextLabel = Label(icon: "خسر", font: .systemFont(ofSize: 12, weight: .medium),
                                      textColor: #colorLiteral(red: 0.9689999819, green: 0.1840000004, blue: 0.4120000005, alpha: 1), isTranform: true, textAlignment: .center)
    private let lostResultLabel = Label(icon: "-4.3", font: .systemFont(ofSize: 24, weight: .regular),
                                        isTranform: true)
    private let lostKGLabel = Label(icon: "kg", font: .systemFont(ofSize: 12, weight: .regular),
                                    isTranform: true)
    
    private let nowTextLabel = Label(icon: "الان", font: .systemFont(ofSize: 12, weight: .medium),
                                     textColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), isTranform: true, textAlignment: .center)
    private let nowResultLabel = Label(icon: "84.3", font: .systemFont(ofSize: 24, weight: .regular),
                                       isTranform: true)
    private let nowKGLabel = Label(icon: "kg", font: .systemFont(ofSize: 12, weight: .regular),
                                   isTranform: true)
    
    private let standartTextLabel = Label(icon: "المعيار", font: .systemFont(ofSize: 12, weight: .medium),
                                          textColor: #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), isTranform: true, textAlignment: .center)
    private let standartResultLabel = Label(icon: "80.1", font: .systemFont(ofSize: 24, weight: .regular),
                                            isTranform: true)
    private let standartKGLabel = Label(icon: "kg", font: .systemFont(ofSize: 12, weight: .regular),
                                        isTranform: true)
    
    public let updateWeightButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.setTitle("تحديث الوزن", for: .normal)
        $0.layer.shadowColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.layer.cornerRadius = (Constants.sW / 5.5) / 2
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = .init(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    })
    
    public let historyButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.setTitleColor(#colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(weight:
            .medium))?.withTintColor(#colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        $0.customButton(text: "التاريخ", font: 16, weight: .regular, shadowColor: .clear)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addconstraints()
        setupGraph()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .systemBackground
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
        
        let dataArr = [60.1, 100.5, 89.4, 108, 110.6, 149.9]
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
        graphContainerView.add(graphView, layoutBlock: { $0.edges() })
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
            $0.topBottom(25, to: hBaseReusltStackView).leading().trailing().height(250)
        })
        updateWeightButton.heightAnchor.constraint(equalToConstant: Constants.sW / 5.5).isActive = true
        add(vForButtonsStackView, layoutBlock: {
            $0.topBottom(30, to: graphContainerView).leading(16).trailing(16).bottom()
        })
        add(topSeparatorView, layoutBlock: { $0.top().leading().trailing().height(1) })
        add(bottomSeparatorView, layoutBlock: { $0.bottom().leading().trailing().height(1) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

// Build Graph
//   [self.SELLineChart removeFromSuperview];
//   self.SELLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0,
// CGRectGetWidth(self.SELChartView.frame), CGRectGetHeight(self.SELChartView.frame))];
//   [self.SELLineChart setBackgroundColor:[UIColor whiteColor]];
//
//   [self.SELLineChart setXLabels:self.SELWeightDateXArray];
//   [self.SELLineChart setXLabelFont:(UIScreen.mainScreen.bounds.size.width == 320.f) ?
//[UIFont fontWithName:@"Rubik-Regular" size:9] : [UIFont fontWithName:@"Rubik-Regular" size:11]];
//   [self.SELLineChart setYLabelFont:(UIScreen.mainScreen.bounds.size.width == 320.f) ?
//[UIFont fontWithName:@"Rubik-Regular" size:9] : [UIFont fontWithName:@"Rubik-Regular" size:11]];
//   [self.SELLineChart setYLabelColor:cELXHColorRGB(110.0f, 110.0f, 121.0f)];
//   [self.SELLineChart setXLabelColor:cELXHColorRGB(110.0f, 110.0f, 121.0f)];
//   [self.SELLineChart setUnitType:@"kg"];
//   [self.SELLineChart setShowSmoothLines:YES];
//   [self.SELLineChart setClipsToBounds:NO];
//
//   PNLineChartData *chartData = [PNLineChartData new];
//   [chartData setColor:cELXHColorRGB(143.0f, 92.0f, 232.0f)];
//   [chartData setItemCount:[self.SELLineChart.xLabels count]];
//   [chartData setInflexionPointColor:cELXHColorRGB(143.0f, 92.0f, 232.0f)];
//   [chartData setInflexionPointStyle:PNLineChartPointStyleCircle];
//   [chartData setInflexionPointWidth:10];
//   chartData.getData = ^(NSUInteger index) {
//       CGFloat yValue = [self.SELWeightKgYArray[index] floatValue];
//
//       return [PNLineChartDataItem dataItemWithY:yValue];
//   };
//   [self.SELLineChart setChartValues:self.SELWeightKgYArray];
//   [self.SELLineChart setChartData:@[chartData]];
//   [self.SELLineChart strokeChart];
//   [self.SELChartView addSubview:self.SELLineChart];

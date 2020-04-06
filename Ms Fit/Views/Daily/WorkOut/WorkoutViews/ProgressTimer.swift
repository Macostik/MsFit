//
//  ProgressTimer.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class ProgressTimer: UIView {
    
    public var timer: Timer!
    public var totalTime = 180
    
    public let progressTimer = specify(CAShapeLayer(), {
        $0.strokeColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.strokeEnd = 0
        $0.fillColor = UIColor.clear.cgColor
        $0.lineCap = .round
        $0.lineWidth = Constants.sH_812 ? 15 : 10
    })
    
    private let trackLayer = specify(CAShapeLayer(), {
        $0.strokeColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        $0.fillColor = UIColor.clear.cgColor
        $0.lineCap = .round
        $0.lineWidth = Constants.sH_812 ? 15 : 10
    })
    
    public lazy var basicAnimation = specify(CABasicAnimation(keyPath: "strokeEnd"), {
        $0.toValue = 1
        $0.duration = CFTimeInterval(totalTime)
        $0.fillMode = .forwards
        $0.isRemovedOnCompletion = false
    })
    
    private lazy var timerLabel = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 34 : 25, weight: .bold)
    })
    
    private let setLabel = specify(UILabel(), {
        $0.text = "Set 1/1"
        $0.textAlignment = .center
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 16 : 13, weight: .medium)
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimer),
                                     userInfo: nil, repeats: true)
        
        let circularPath = UIBezierPath(arcCenter:
            .init(x: (Constants.sH_812 ? Constants.sW * 0.5 : Constants.sW * 0.4) / 2,
                  y: (Constants.sH_812 ? Constants.sW * 0.5 : Constants.sW * 0.4) / 2),
                                        radius: Constants.sH_812 ? Constants.sW * 0.25 : Constants.sW * 0.2,
                                        startAngle: -.pi / 2, endAngle: 2 * .pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        progressTimer.path = circularPath.cgPath
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressTimer)
        
        add(timerLabel, layoutBlock: { $0.center() })
        add(setLabel, layoutBlock: { $0.centerX().bottomTop(Constants.sW * -0.03, to: timerLabel) })
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc func handleTimer() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            timer.invalidate()
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

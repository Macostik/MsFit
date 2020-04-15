//
//  ProgressTimer.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class ProgressTimer: UIView {
    
    private var viewModel: StartWorkoutSceneViewModel?
    public var timer: Timer!
    public var totalTime = 30
    
    public let progressTimer = specify(CAShapeLayer(), {
        $0.strokeColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.strokeEnd = 0
        $0.fillColor = UIColor.clear.cgColor
        $0.lineCap = .round
        $0.lineWidth = Constants.sH_812 ? 15 : Constants.sH_667 ? 15 : 10
    })
    
    private let trackLayer = specify(CAShapeLayer(), {
        $0.strokeColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        $0.fillColor = UIColor.clear.cgColor
        $0.lineCap = .round
        $0.lineWidth = Constants.sH_812 ? 15 : Constants.sH_667 ? 15 : 10
    })
    
    public lazy var basicAnimation = specify(CABasicAnimation(keyPath: "strokeEnd"), {
        $0.toValue = 1
        $0.fillMode = .forwards
        $0.isRemovedOnCompletion = false
    })
    
    public lazy var timerLabel = specify(UILabel(), {
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 34 : 25, weight: .bold)
    })
    
    private let setLabel = specify(UILabel(), {
        $0.text = "تعيين 1/1"
        $0.textAlignment = .center
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 16 : 13, weight: .medium)
    })
    
    init(with viewModel: StartWorkoutSceneViewModel? = nil) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setupUI()
        addConstraints()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .clear
        basicAnimation.duration = CFTimeInterval(totalTime)
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        let circularPath = UIBezierPath(arcCenter:
            .init(x: (Constants.sH_812 ? Constants.sW * 0.6 : Constants.sH_667 ?
                Constants.sW * 0.5 : Constants.sW * 0.4) / 2,
                  y: (Constants.sH_812 ? Constants.sW * 0.6 : Constants.sH_667 ?
                    Constants.sW * 0.5 : Constants.sW * 0.4) / 2),
                                        radius: Constants.sH_812 ? Constants.sW * 0.3 : Constants.sH_667 ?
                                            Constants.sW * 0.25 : Constants.sW * 0.2,
                                        startAngle: .pi / 2, endAngle: 2.5 * .pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        progressTimer.path = circularPath.cgPath
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressTimer)
    }
    
    fileprivate func addConstraints() {
        add(timerLabel, layoutBlock: { $0.center() })
        add(setLabel, layoutBlock: { $0.centerX().bottomTop(Constants.sW * -0.03, to: timerLabel) })
    }
    
    public func toggleTimer(isOn: Bool) {
        if isOn {
            resumeAnimation()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
                guard let `self` = self else { return }
                self.timerLabel.text = self.timeFormatted(self.totalTime)
                if self.totalTime != 0 {
                    self.totalTime -= 1
                } else {
                    self.timer.invalidate()
                    self.viewModel?.presentRestWorkoutObserver.onNext(())
                }
            })
        } else {
            pauseAnimation()
            timer.invalidate()
        }
    }
    
    public func pauseAnimation() {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    public func resumeAnimation() {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    public func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

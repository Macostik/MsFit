//
//  DaysOfCircleView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 27.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class DaysOfCircleView: UIView {
    
    private let baseView = specify(UIView(), { $0.backgroundColor = .clear })
    
    private let daysLabel = specify(UILabel(), {
        $0.font = UIFont.systemFont(ofSize: Constants.sH_667 ? 80 : 60, weight: .bold)
        $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.text = "\(RealmProvider.shared.realm.objects(DailySceneModel.self).first?.day_number ?? 0)"
    })
    
    private let dayLabel = specify(UILabel(), {
        $0.text = "يوم"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 22 : 18, weight: .medium)
        $0.textAlignment = .center
        $0.textColor = #colorLiteral(red: 0.7254901961, green: 0.6823529412, blue: 1, alpha: 1)
    })
    
    private let leftLabel = specify(UILabel(), {
        $0.text = "باقي"
        $0.font = .systemFont(ofSize: Constants.sH_667 ? 22 : 18, weight: .medium)
        $0.textAlignment = .center
        $0.textColor = #colorLiteral(red: 0.7254901961, green: 0.6823529412, blue: 1, alpha: 1)
    })
    
    private func createDailyTimeView() -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1058823529, blue: 0.1529411765, alpha: 0.2972495719)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        handleUI()
        addConstraints()
        
    }
    fileprivate func handleUI() {
        backgroundColor = .clear
    }
    
    fileprivate func addConstraints() {
        let listView = (0...14).compactMap({ [weak self] _ in self?.createDailyTimeView() })
        let days = RealmProvider.shared.realm.objects(DailySceneModel.self).first?.day_number ?? 0
        for index in 0..<days {
            let view = listView[index]
            view.backgroundColor = .systemBackground
        }
        
        // start circle days
        add(baseView, layoutBlock: { $0.centerX().centerY().size(Constants.sW / 1.9) })
        
        baseView.add(listView[0], layoutBlock: { $0.centerX().top().size(16) })
        baseView.add(listView[1], layoutBlock: {
            $0.centerX(Constants.sW * 0.11).centerY(Constants.sW * -0.21).size(16)
        })
        baseView.add(listView[2], layoutBlock: {
            $0.centerX(Constants.sW * 0.19).centerY(Constants.sW * -0.14).size(16)
        })
        baseView.add(listView[3], layoutBlock: {
            $0.leading(-1).bottomCenterY(Constants.sW * -0.03, to: baseView).size(16)
        })
        baseView.add(listView[4], layoutBlock: {
            $0.leading(-1).topCenterY(Constants.sW * 0.03, to: baseView).size(16)
        })
        baseView.add(listView[5], layoutBlock: {
            $0.centerX(Constants.sW * 0.19).centerY(Constants.sW * 0.14).size(16)
        })
        baseView.add(listView[6], layoutBlock: {
            $0.centerX(Constants.sW * 0.11).centerY(Constants.sW * 0.21).size(16)
        })
        //----- middle
        baseView.add(listView[7], layoutBlock: { $0.centerX().bottom().size(16) })
        //----- middle
        baseView.add(listView[8], layoutBlock: {
            $0.centerX(Constants.sW * -0.11).centerY(Constants.sW * 0.21).size(16)
        })
        baseView.add(listView[9], layoutBlock: {
            $0.centerX(Constants.sW * -0.19).centerY(Constants.sW * 0.14).size(16)
        })
        baseView.add(listView[10], layoutBlock: {
            $0.trailing(1).topCenterY(Constants.sW * 0.03, to: baseView).size(16)
        })
        baseView.add(listView[11], layoutBlock: {
            $0.trailing(1).bottomCenterY(Constants.sW * -0.03, to: baseView).size(16)
        })
        baseView.add(listView[12], layoutBlock: {
            $0.centerX(Constants.sW * -0.19).centerY(Constants.sW * -0.14).size(16)
        })
        baseView.add(listView[13], layoutBlock: {
            $0.centerX(Constants.sW * -0.11).centerY(Constants.sW * -0.21).size(16)
        })
        baseView.add(daysLabel, layoutBlock: { $0.center() })
        baseView.add(dayLabel, layoutBlock: { $0.centerX().topBottom(-14, to: daysLabel) })
        baseView.add(leftLabel, layoutBlock: { $0.centerX().bottomTop(4, to: daysLabel) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

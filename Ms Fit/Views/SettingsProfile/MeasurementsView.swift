//
//  MeasurementsView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class MeasurementsView: UIView {
    
    private let measurView = specify(UIView(), { $0.backgroundColor = .clear })
    private let chestView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let waistView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let thighView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let armsView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let updateMeasureView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    
    private let measurSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    private let chestSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    private let waistSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    private let thighSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    private let armsSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    private let measureSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    
    private let chestImageView = specify(UIImageView(), {
        $0.contentMode = .scaleAspectFit
        $0.image = #imageLiteral(resourceName: "chest")
    })
    private let waistImageView = specify(UIImageView(), {
        $0.contentMode = .scaleAspectFit
        $0.image = #imageLiteral(resourceName: "waist")
    })
    private let thighImageView = specify(UIImageView(), {
        $0.contentMode = .scaleAspectFit
        $0.image = #imageLiteral(resourceName: "legs")
    })
    private let armsImageView = specify(UIImageView(), {
        $0.contentMode = .scaleAspectFit
        $0.image = #imageLiteral(resourceName: "arm")
    })
    
    private let chestLeftImageView = UIImageView(image: UIImage(systemName: "chevron.left", withConfiguration:
        UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), renderingMode: .alwaysOriginal))
    private let waistLeftImageView = UIImageView(image: UIImage(systemName: "chevron.left", withConfiguration:
        UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), renderingMode: .alwaysOriginal))
    private let thighLeftImageView = UIImageView(image: UIImage(systemName: "chevron.left", withConfiguration:
        UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), renderingMode: .alwaysOriginal))
    private let armsLeftImageView = UIImageView(image: UIImage(systemName: "chevron.left", withConfiguration:
        UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), renderingMode: .alwaysOriginal))
    
    private let chestLabel = Label(icon: "Chest", font: .systemFont(ofSize: 16, weight: .regular),
                                   size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let waistLabel = Label(icon: "Waist", font: .systemFont(ofSize: 16, weight: .regular),
                                   size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let thighLabel = Label(icon: "Thigh", font: .systemFont(ofSize: 16, weight: .regular),
                                   size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let armsLabel = Label(icon: "Arms", font: .systemFont(ofSize: 16, weight: .regular),
                                   size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let chestCountLabel = Label(icon: "60.0", font: .systemFont(ofSize: 16, weight: .regular),
                                   size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let waistCountLabel = Label(icon: "35.0", font: .systemFont(ofSize: 16, weight: .regular),
                                   size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let thighCountLabel = Label(icon: "25.0", font: .systemFont(ofSize: 16, weight: .regular),
                                   size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let armsCountLabel = Label(icon: "10.0", font: .systemFont(ofSize: 16, weight: .regular),
                                   size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let chest_CM = Label(icon: "cm", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let waist_CM = Label(icon: "cm", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let thigh_CM = Label(icon: "cm", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    private let arms_CM = Label(icon: "cm", font: .systemFont(ofSize: 12, weight: .regular),
                                   size: 12, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let measurementLabel = Label(icon: "Measurements",font: .systemFont(ofSize: 13, weight: .regular),
                                         size: 13, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1))
    
    public let updateMeasureButton = specify(UIButton(type: .roundedRect), {
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.setTitle("Update Measurements", for: .normal)
        $0.layer.shadowColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.layer.cornerRadius = (Constants.sW / 5.5) / 2
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = .init(width: 0, height: 3)
        $0.layer.shadowRadius = 3
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        handleUI()
        addConstraints()
    }
    
    fileprivate func handleUI() {
        backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        chest_CM.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        waist_CM.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        thigh_CM.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        arms_CM.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    fileprivate func addConstraints() {
        measurView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let vBaseStackView = VStackView(arrangedSubviews: [measurView, chestView, waistView,
                                                           thighView, armsView])
        vBaseStackView.distribution = .fillEqually
        
        chestImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        chestImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let hChestStackView = HStackView(arrangedSubviews: [chestImageView, chestLabel], spacing: 8)
        let hChestCountStackView = HStackView(arrangedSubviews: [chestLeftImageView, chestCountLabel],
                                              spacing: 5)
        hChestCountStackView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        waistImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        waistImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let hWaistStackView = HStackView(arrangedSubviews: [waistImageView, waistLabel], spacing: 14)
        let hWaistCountStackView = HStackView(arrangedSubviews: [waistLeftImageView, waistCountLabel],
                                              spacing: 5)
        hWaistCountStackView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        thighImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        thighImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let hThighStackView = HStackView(arrangedSubviews: [thighImageView, thighLabel], spacing: 8)
        let hThighCountStackView = HStackView(arrangedSubviews: [thighLeftImageView, thighCountLabel],
                                              spacing: 5)
        hThighCountStackView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        armsImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        armsImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let hArmStackView = HStackView(arrangedSubviews: [armsImageView, armsLabel], spacing: 8)
        let hArmCountStackView = HStackView(arrangedSubviews: [armsLeftImageView, armsCountLabel],
                                              spacing: 5)
        hArmCountStackView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        measurView.add(measurementLabel, layoutBlock: { $0.leading(16).bottom(10) })
        measurView.add(measurSeparatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
        chestView.add(hChestStackView, layoutBlock: { $0.leading(16).centerY() })
        chestView.add(hChestCountStackView, layoutBlock: { $0.trailing(16).centerY() })
        chestView.add(chest_CM, layoutBlock: {
            $0.trailingLeading(-4, to: hChestCountStackView).centerY(1, to: hChestCountStackView)
        })
        chestView.add(chestSeparatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
        
        waistView.add(hWaistStackView, layoutBlock: { $0.leading(16).centerY() })
        waistView.add(hWaistCountStackView, layoutBlock: { $0.trailing(16).centerY() })
        waistView.add(waist_CM, layoutBlock: {
            $0.trailingLeading(-4, to: hWaistCountStackView).centerY(1, to: hWaistCountStackView)
        })
        waistView.add(waistSeparatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
        
        thighView.add(hThighStackView, layoutBlock: { $0.leading(16).centerY() })
        thighView.add(hThighCountStackView, layoutBlock: { $0.trailing(16).centerY() })
        thighView.add(thigh_CM, layoutBlock: {
            $0.trailingLeading(-4, to: hThighCountStackView).centerY(1, to: hThighCountStackView)
        })
        thighView.add(thighSeparatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
        
        armsView.add(hArmStackView, layoutBlock: { $0.leading(16).centerY() })
        armsView.add(hArmCountStackView, layoutBlock: { $0.trailing(16).centerY() })
        armsView.add(arms_CM, layoutBlock: {
            $0.trailingLeading(-4, to: hArmCountStackView).centerY(1, to: hArmCountStackView)
        })
        armsView.add(armsSeparatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
        
        add(vBaseStackView, layoutBlock: { $0.top().leading().trailing() })
        add(updateMeasureView, layoutBlock: {
            $0.topBottom(to: vBaseStackView).leading().bottom(30).trailing()
        })
        updateMeasureView.add(updateMeasureButton, layoutBlock: {
            $0.leading(16).trailing(16).top(20).bottom(20).height(Constants.sW / 5.5)
        })
        updateMeasureView.add(measureSeparatorView, layoutBlock: {$0.bottom().trailing().leading().height(1)})
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

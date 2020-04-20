//
//  AllVideoCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AllVideoCell: UICollectionViewCell, CellIdentifierable {
    
    fileprivate let disposeBag = DisposeBag()
    
    private let videoPlayer = YouTubePlayerView()
    
    private let containerView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = .init(width: 0, height: 2)
        $0.clipsToBounds = false
        $0.layer.cornerRadius = 6
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    })
    
    private let tipText = Label(icon: "", font: .systemFont(ofSize: 16, weight: .regular), textColor: #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1),
                                isTranform: false, textAlignment: .right)
    
    private let startButton = specify(UIButton(type: .roundedRect), {
        $0.setTitle("للبدء", for: .normal)
        $0.tintColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.layer.borderColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 30/2
        $0.clipsToBounds = true
    })
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        handleUI()
        setupBindings()
        addConstraints()
    }
    
    private func handleUI() {
        backgroundColor = .clear
        videoPlayer.layer.cornerRadius = 6
        videoPlayer.clipsToBounds = true
        videoPlayer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        videoPlayer.backgroundColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        
        guard let url = URL(string: "https://www.youtube.com/watch?v=wfRl4RfQnPM") else { return }
        videoPlayer.loadVideoURL(url)
    }
    
    fileprivate func setupBindings() {
    }
    
    func addConstraints() {
        let vContainerStackView = VStackView(arrangedSubviews: [videoPlayer, containerView])
        
        containerView.add(tipText, layoutBlock: { $0.leading(16).top(25).bottom(25) })
        containerView.add(startButton, layoutBlock: { $0.trailing(16).height(30).centerY().width(60) })
        add(vContainerStackView, layoutBlock: { $0.top(15).bottom().trailing(15).leading(15) })
    }
    
    public func setup(_ arm: ArmWorkoutList) {
        tipText.text = arm.description()
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

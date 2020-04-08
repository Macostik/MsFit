//  
//  StartWorkoutSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StartWorkoutSceneViewController: BaseViewController<StartWorkoutSceneViewModel> {
    
    private let progressTimerView = ProgressTimer()
    private lazy var timerPopupView = TimerPopupView(with: self.viewModel)
    private let videoPlayer = { YouTubePlayerView.shared }()
    
    private var isTimer = false
    private var isAnimation = false
    private let numberExercise = Array(1...20)
    
    private let startConfiguration = UIImage.SymbolConfiguration(weight: .regular)
    internal lazy var startWorkoutBtn = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "play.fill", withConfiguration: startConfiguration)?
            .withTintColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        $0.titleEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        $0.setTitle("Start", for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), for: .normal)
        $0.layer.borderColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        $0.layer.borderWidth = 1
        $0.circled = true
    })
    
    private let topSeparator = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    private let bottomSeparator = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    
    private let exerciseLabel = specify(UILabel(), {
        $0.text = "Flutter kicks with Scissors"
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.font = .systemFont(ofSize: Constants.sH_812 ? 22 : 18, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .center
    })
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(StartWorkoutCell.self,
                                forCellWithReuseIdentifier: StartWorkoutCell.identifier)
        
        return collectionView
    }()
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        Observable.just(numberExercise)
            .bind(to: collectionView.rx.items(cellIdentifier: StartWorkoutCell.identifier,
                                              cellType: StartWorkoutCell.self)) { _, model, cell in
                                                cell.setup(model)
        }.disposed(by: disposeBag)
        
        startWorkoutBtn.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                if self.isAnimation {
                    self.progressTimerView.toggleTimer(isOn: self.isTimer)
                    self.handlePopupView()
                    self.videoPlayer.pause()
                    self.isAnimation.toggle()
                } else {
                    UIView.animate(withDuration: 0.3) {
                        self.startWorkoutBtn.setImage(UIImage(systemName: "pause.fill",
                                                              withConfiguration: self.startConfiguration)?
                            .withTintColor(#colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
                        self.startWorkoutBtn.setTitle("Pause", for: .normal)
                    }
                    self.progressTimerView.progressTimer.add(self.progressTimerView.basicAnimation,
                                                             forKey: "urSoBasic")
                    self.progressTimerView.toggleTimer(isOn: !self.isTimer)
                }
                self.isAnimation.toggle()
            }).disposed(by: disposeBag)
        
        timerPopupView.contunieButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.videoPlayer.play()
                self.progressTimerView.toggleTimer(isOn: !self.isTimer)
                UIView.animate(withDuration: 0.4, delay: 0, animations: {
                    self.timerPopupView.baseVStackView.transform =
                        CGAffineTransform(translationX: 0, y: self.timerPopupView.baseVStackView.height)
                }, completion: { _ in
                    self.timerPopupView.isHidden = true
                })
            }).disposed(by: disposeBag)
        
        timerPopupView.restartExeciseButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
        
        timerPopupView.endWorkoutButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissDailySceneObserver)
            .disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        timerPopupView.isHidden = true
        videoPlayer.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        guard let url = URL(string: "https://www.youtube.com/watch?v=wfRl4RfQnPM") else { return }
        videoPlayer.loadVideoURL(url)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.videoPlayer.play()
        }
    }
    
    fileprivate func addConstraints() {
        topSeparator.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        bottomSeparator.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        let exerciseVStackView = VStackView(arrangedSubviews: [topSeparator, exerciseLabel, bottomSeparator],
                                            spacing: Constants.sH_812 ? 30 : 20)
        
        view.add(videoPlayer, layoutBlock: {
            $0.top().leading().trailing().height(Constants.sH_812 ? Constants.sW * 0.68 : Constants.sW * 0.63)
        })
        view.add(collectionView, layoutBlock: {
            $0.topBottom(Constants.sH_812 ? 25 : 10, to: videoPlayer).leading(16).trailing(16).height(50)
        })
        view.add(exerciseVStackView, layoutBlock: {
            $0.topBottom(Constants.sH_812 ? 25 : 10, to: collectionView).leading(16).trailing(16).centerX()
        })
        view.add(startWorkoutBtn, layoutBlock: {
            $0.bottom(Constants.sH_812 ? 30 : 15).centerX()
                .width(Constants.sW * 0.4).height(Constants.sW * 0.15)
        })
        view.add(progressTimerView, layoutBlock: {
            $0.bottomTop(Constants.sH_812 ? Constants.sW * -0.09 : Constants.sW * -0.06, to: startWorkoutBtn)
                .size(Constants.sH_812 ? Constants.sW * 0.6 : Constants.sH_667 ?
                    Constants.sW * 0.5 : Constants.sW * 0.4).centerX()
        })
        view.add(timerPopupView, layoutBlock: { $0.edges() })
    }
    
    fileprivate func handlePopupView() {
        timerPopupView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.timerPopupView.baseVStackView.transform = .identity
        }
    }
}

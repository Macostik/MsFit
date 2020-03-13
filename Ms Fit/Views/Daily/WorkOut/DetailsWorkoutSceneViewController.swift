//  
//  DetailsWorkoutSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 06.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsWorkoutSceneViewController: BaseViewController<DetailsWorkoutSceneViewModel> {
    
    private let previewImagePagerView = PreviewImagePagerView()
    
    private let scrollView = specify(UIScrollView(), {
        $0.showsHorizontalScrollIndicator = false
    })
    
    private let nameExerciseView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let musclesInvolvedView = specify(UIView(), { $0.backgroundColor = .systemBackground })
    private let performReoetitionView = specify(UIView(), {  $0.backgroundColor = .systemBackground })
    private let readyToStartView = specify(UIView(), {  $0.backgroundColor = .clear })
    private let notesView = specify(UIView(), {
        $0.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.layer.shadowOpacity = 0.7
        $0.backgroundColor = .systemBackground
        $0.layer.shadowOffset = .init(width: 0, height: 3)
    })
    
    private let chevronConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: chevronConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let previousButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "previous_icon.pdf"), for: .normal)
        $0.tintColor = .systemBackground
        $0.customButton(text: "Previous", font: 20, weight: .medium,
                        shadowColor: .clear, bgColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), isCircled: false)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    })
    
    private let nextButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(#imageLiteral(resourceName: "next_icon.pdf"), for: .normal)
        $0.tintColor = .systemBackground
        $0.customButton(text: "Next", font: 20, weight: .medium,
                        shadowColor: .clear, bgColor: #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1), isCircled: false)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    })
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.7250000238, green: 0.2119999975, blue: 0.7799999714, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let navPreviewLabel = specify(UILabel(), {
        $0.text = "Preview"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let nameExerciseLabel = specify(UILabel(), {
        $0.text = "Crunches"
        $0.font = .systemFont(ofSize: 22, weight: .medium)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let sets_repsLabel = Label(icon: "5 sets/20 reps", font:
        .systemFont(ofSize: 14, weight: .regular), size: 14, textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1))
    
    private let nameSeparatorView = specify(UILabel(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    
    private let musclesInvolvedLabel = Label(icon: "Muscles involved", font:
        .systemFont(ofSize: 16, weight: .medium), size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let shouldersLabel = Label(icon: "Shoulders", font:
        .systemFont(ofSize: 16, weight: .regular), size: 16, textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1))
    
    private let musclesSeparatorView = specify(UILabel(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    
    private let performLabel = Label(icon: "This is how to perform one reoetition", font:
        .systemFont(ofSize: 16, weight: .medium), size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let oneLabel = Label(icon: "Stand up straight and hold straight arms 1", font:
        .systemFont(ofSize: 14, weight: .regular), size: 14, textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1))
    
    private let twoLabel = Label(icon: "- Stand up straight2", font:
        .systemFont(ofSize: 14, weight: .regular), size: 14, textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1))
    
    private let threeLabel = Label(icon: "- Stand up straight3", font:
        .systemFont(ofSize: 14, weight: .regular), size: 14, textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1))
    
    private let fourLabel = Label(icon: "- Stand up straight4", font:
        .systemFont(ofSize: 14, weight: .regular), size: 14, textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1))
    
    private let fiveLabel = Label(icon: "- Stand up straight5", font:
        .systemFont(ofSize: 14, weight: .regular), size: 14, textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1))
    
    private let sixeLabel = Label(icon: "- Stand up straight6", font:
        .systemFont(ofSize: 14, weight: .regular), size: 14, textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1))
    
    private let sevenLabel = Label(icon: "- Stand up straight7", font:
        .systemFont(ofSize: 14, weight: .regular), size: 14, textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1))
    
    private let performSeparatorView = specify(UILabel(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    
    private let noteLabel = Label(icon: "Note", font:
           .systemFont(ofSize: 16, weight: .medium), size: 16, textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1))
    
    private let noteOneLabel = Label(icon: "- Stand up straight1", font:
        .systemFont(ofSize: 14, weight: .regular), size: 14, textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1))
    
    private let noteTwoLabel = Label(icon: "- Stand up straight2", font:
        .systemFont(ofSize: 14, weight: .regular), size: 14, textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1))
    
    private let noteSeparatorView = specify(UILabel(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    
    private let startConfiguration = UIImage.SymbolConfiguration(weight: .thin)
    internal lazy var startWorkoutButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "play.fill", withConfiguration: startConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
        $0.customButton(text: "Start Workout", font: 20, weight: .bold,
                        shadowColor: #colorLiteral(red: 0.5019999743, green: 0.3330000043, blue: 0.8709999919, alpha: 1), bgColor: #colorLiteral(red: 0.5019999743, green: 0.3330000043, blue: 0.8709999919, alpha: 1), isCircled: true)
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
    })
    
    private let readyToStartLabel = specify(UILabel(), {
        $0.text = "This is just an exercise preview. Ready to start?"
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.textAlignment = .center
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    fileprivate func addConstraints() {
        let hStackView = HStackView(arrangedSubviews: [previousButton, nextButton], spacing: 0.5)
        hStackView.distribution = .fillEqually
        
        previewImagePagerView.heightAnchor.constraint(equalToConstant:
            Constants.sH_812 ? 250 : 200).isActive = true
        let baseVStackView = VStackView(arrangedSubviews: [
            previewImagePagerView, nameExerciseView, musclesInvolvedView,
            performReoetitionView, notesView, readyToStartView
        ])
        
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navPreviewLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navPreviewLabel).leading(4).size(44) })
        view.add(hStackView, layoutBlock: { $0.leading().trailing().bottom().height(Constants.sW / 6.5) })
        view.add(scrollView, layoutBlock: {
            $0.topBottom(to: navigationView).width(Constants.sW).bottomTop(to: hStackView)
        })
        scrollView.add(baseVStackView, layoutBlock: { $0.top().bottom().width(Constants.sW) })
        nameExerciseView.add(nameExerciseLabel, layoutBlock: { $0.top(60).centerX().bottom(40) })
        nameExerciseView.add(sets_repsLabel, layoutBlock: { $0.trailing(16).bottom(16) })
        nameExerciseView.add(nameSeparatorView, layoutBlock: {
            $0.bottom().leading(16).trailing(16).height(1)
        })
        
        let muscVStackView = VStackView(arrangedSubviews: [musclesInvolvedLabel, shouldersLabel], spacing: 10)
        musclesInvolvedView.add(muscVStackView, layoutBlock: { $0.trailing(16).leading(16).top(12).bottom(8)})
        musclesInvolvedView.add(musclesSeparatorView, layoutBlock: {
            $0.bottom().leading(16).trailing(16).height(1)
        })
        
        let vStackView = VStackView(arrangedSubviews: [performLabel, VStackView(arrangedSubviews: [
            oneLabel, twoLabel, threeLabel, fourLabel, fiveLabel, sixeLabel], spacing: 10)
        ], spacing: 15)
        performReoetitionView.add(vStackView, layoutBlock: { $0.leading(16).trailing(16).top(12).bottom(40) })
        performReoetitionView.add(performSeparatorView, layoutBlock: {
            $0.bottom().leading(16).trailing(16).height(1)
        })
        
        let noteVStackView = VStackView(arrangedSubviews: [
            noteLabel, VStackView(arrangedSubviews: [noteOneLabel, noteTwoLabel], spacing: 10)
        ], spacing: 15)
        notesView.add(noteVStackView, layoutBlock: { $0.leading(16).trailing(16).top(12).bottom(40) })
        notesView.add(noteSeparatorView, layoutBlock: { $0.bottom().leading(16).trailing(16).height(1) })
        
        startWorkoutButton.heightAnchor.constraint(equalToConstant: Constants.sW / 6.5).isActive = true
        let readyStartStackView = VStackView(arrangedSubviews: [readyToStartLabel, startWorkoutButton],
                                             spacing: 10)
        readyToStartView.add(readyStartStackView, layoutBlock: {
            $0.top(25).leading(16).trailing(16).bottom(16)
        })
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
    }
    
    func createSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        return view
    }
}

//  
//  ExerciseDetailSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 24.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExerciseDetailSceneViewController: BaseViewController<ExerciseDetailSceneViewModel> {
    
    private let previewImagePagerView = PreviewImagePagerView()
    
    private let scrollView = specify(UIScrollView(), {
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = .init(top: 0, left: 0, bottom: 5, right: 0)
    })
    
    private let nameExerciseView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
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
        $0.setImage(UIImage(systemName: "xmark", withConfiguration: chevronConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let gradientView = specify(GradientView(), {
        $0.topColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.3)
        $0.bottomColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.01)
        $0.startPointX = 0.8
        $0.startPointY = 0.4
        $0.endPointX = 0.8
        $0.endPointY = 0.8
    })
    
    private let nameExerciseLabel = Label(icon: "Crunches", font: .systemFont(ofSize: 22, weight: .medium),
                                     textColor: #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.168627451, alpha: 1), isTranform: true, textAlignment: .center)
    
    private let sets_repsLabel = Label(icon: "5 مجموعات / 20 ممثلاً", font:
        .systemFont(ofSize: 14, weight: .regular), textColor: #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1), isTranform: false, textAlignment: .right)
    
    private let nameSeparatorView = specify(UILabel(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    
    private let musclesInvolvedLabel = Label(icon: "العضلات المعنية", font:
        .systemFont(ofSize: 16, weight: .medium), textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: false, textAlignment: .right)
    
    private let shouldersLabel = Label(icon: "أكتاف", font:
        .systemFont(ofSize: 16, weight: .regular), textColor: #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1), isTranform: false, textAlignment: .right)
    
    private let musclesSeparatorView = specify(UILabel(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    
    private let performLabel = Label(icon: "هذه هي طريقة إجراء إعادة اختبار واحدة", font:
        .systemFont(ofSize: 16, weight: .medium), textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: false, textAlignment: .right)
    
    private let discriptionLabel = specify(UILabel(), {
        $0.text = """
        - قف بشكل مستقيم 1\n
        - قف بشكل مستقيم 1\n
        - قف بشكل مستقيم 1\n
        - قف بشكل مستقيم 1\n
        - قف بشكل مستقيم 1\n
        - قف بشكل مستقيم 1\n
        - قف بشكل مستقيم 1
        """
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1)
        $0.textAlignment = .right
    })
    
    private let performSeparatorView = specify(UILabel(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    
    private let noteLabel = Label(icon: "ملحوظة", font: .systemFont(ofSize: 16, weight: .medium),
                                  textColor: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1), isTranform: false, textAlignment: .right)
    
    private let noteDiscriptionLabel = specify(UILabel(), {
        $0.text = """
        - قف بشكل مستقيم 1\n
        - قف بشكل مستقيم 1
        """
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4745098039, alpha: 1)
        $0.textAlignment = .right
    })
    
    private let noteSeparatorView = specify(UILabel(), { $0.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1) })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
    }
    
    override func setupBindings() {
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
        
        scrollView.rx.contentOffset
            .subscribe(onNext: { offset in
                self.scrollView.contentOffset.y = offset.y < 0.0 ? 0.0 : self.scrollView.contentOffset.y
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraints() {
        previewImagePagerView.heightAnchor.constraint(equalToConstant: Constants.sW * 0.8).isActive = true
        let baseVStackView = VStackView(arrangedSubviews: [
            previewImagePagerView, nameExerciseView, musclesInvolvedView,
            performReoetitionView, notesView, readyToStartView
        ])
    
        view.add(scrollView, layoutBlock: {
            $0.top(Constants.sH_812 ? -45 : -20).width(Constants.sW).bottom()
        })
        view.add(gradientView, layoutBlock: { $0.top().leading().trailing().height(80) })
        view.add(closeButton, layoutBlock: {
            $0.top(Constants.sH_812 ? 16 : 6).leading(Constants.sH_812 ? 16 : 6).size(44)
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
        
        let vStackView = VStackView(arrangedSubviews: [
            performLabel, discriptionLabel
        ], spacing: 15)
        performReoetitionView.add(vStackView, layoutBlock: { $0.leading(16).trailing(16).top(12).bottom(40) })
        performReoetitionView.add(performSeparatorView, layoutBlock: {
            $0.bottom().leading(16).trailing(16).height(1)
        })
        
        let noteVStackView = VStackView(arrangedSubviews: [
            noteLabel, VStackView(arrangedSubviews: [noteDiscriptionLabel])
        ], spacing: 15)
        notesView.add(noteVStackView, layoutBlock: { $0.leading(16).trailing(16).top(12).bottom(40) })
        notesView.add(noteSeparatorView, layoutBlock: { $0.bottom().leading(16).trailing(16).height(1) })
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
}

//  
//  ContactUsSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 20.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class ContactUsSceneViewController: BaseViewController<ContactUsSceneViewModel> {
    
    private let subjectMenuView = SubjectMenuTableView()
    private var isShowMenu = false
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "الاتصال بنا"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let warningImageView = specify(UIImageView(), {
        $0.image = UIImage(named: "warning")
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private var scrollView = specify(UIScrollView(), {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    })
    
    private let yourEmailView = specify(UIView(), { $0.backgroundColor = .clear })
    private let yourQuestionView = specify(UIView(), { $0.backgroundColor = .clear })
    private let emailSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    private let questSeparatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1) })
    
    private let yourEmailLabel = Label(icon: "بريدك الالكتروني",
                                       font: .systemFont(ofSize: 13, weight: .regular),
                                       textColor: #colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1), isTranform: false, textAlignment: .right)
    
    private let yourTextField = specify(UITextField(), {
        $0.borderStyle = .none
        $0.placeholder = "yura.test@mail.com"
        $0.textAlignment = .right
    })
    
    private let validLabel = Label(icon: "تفقد البريد الإلكتروني",
                                   font: .systemFont(ofSize: 15, weight: .regular),
                                   textColor: #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1), isTranform: false, textAlignment: .right)
    private let yourQuestionsLabel = Label(icon: "الأسئلة",
                                           font: .systemFont(ofSize: 13, weight: .regular),
                                           textColor: #colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1), isTranform: false, textAlignment: .right)
    
    private let yourQuestionTextView = specify(UITextView(), {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let sendEmailButton = specify(UIButton(type: .roundedRect), {
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.customButton(text: "إرسال", font: 20, weight: .bold,
                        shadowColor: #colorLiteral(red: 0.5019999743, green: 0.3330000043, blue: 0.8709999919, alpha: 1), bgColor: #colorLiteral(red: 0.5019999743, green: 0.3330000043, blue: 0.8709999919, alpha: 1), isCircled: true)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {        
        closeButton.rx.tap
            .map({ _ in })
            .bind(to: viewModel!.dismissObserver)
            .disposed(by: disposeBag)
        
        sendEmailButton.animateWhenPressed(disposeBag: disposeBag)
        sendEmailButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                if self.yourQuestionTextView.text.isEmpty {
                    UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [.repeat], animations: {
                        UIView.modifyAnimations(withRepeatCount: 4, autoreverses: false) {
                            self.warningImageView.isHidden = false
                            self.warningImageView.transform = CGAffineTransform(scaleX: 2.2, y: 2.2)
                        }
                    }, completion: { _ in
                        self.warningImageView.isHidden = true
                    })
                } else {
                    self.viewModel?.presentSentMessageObserver.onNext(())
                }
            }).disposed(by: disposeBag)
        
        subjectMenuView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [unowned self] _ in
                if self.isShowMenu {
                    self.animationMenu(constant: 0)
                } else {
                    self.animationMenu(constant: 200)
                }
                self.isShowMenu.toggle()
            }).disposed(by: disposeBag)
        
        yourQuestionTextView.rx.didChange
            .subscribe(onNext: { _ in
                let size = CGSize(width: Constants.sW, height: .infinity)
                let estimatedSize = self.yourQuestionTextView.sizeThatFits(size)
                
                self.yourQuestionTextView.constraints.forEach { (constraints) in
                    if constraints.firstAttribute == .height {
                        constraints.constant = estimatedSize.height
                        self.yourQuestionTextView.layoutIfNeeded()
                    }
                }
            }).disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [scrollView] keyboardVisibleHeight in
                scrollView.contentInset.bottom = keyboardVisibleHeight + Constants.sW * 0.1
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        warningImageView.isHidden = true
        
        let dismissTapGestureRecognized = UITapGestureRecognizer(target: self.view,
                                                                 action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(dismissTapGestureRecognized)
    }
    
    fileprivate func addConstraints() {
        let vBaseStackView = VStackView(arrangedSubviews: [subjectMenuView, yourEmailView, yourQuestionView])
        let vYourEmailStackView = VStackView(arrangedSubviews: [yourEmailLabel, yourTextField], spacing: 10)
        let hQuestionStackView = VStackView(arrangedSubviews: [
            validLabel, yourQuestionsLabel, yourQuestionTextView
        ], spacing: 6)
        
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 8) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navTextLabel).leading(4).size(44)})
        view.add(scrollView, layoutBlock: {
            $0.topBottom(to: navigationView).width(Constants.sW).bottom()
        })
        
        yourEmailView.add(vYourEmailStackView, layoutBlock: { $0.leading().top(5).bottom(10).trailing() })
        yourEmailView.add(emailSeparatorView, layoutBlock: { $0.leading().trailing().bottom().height(1) })
        
        yourQuestionView.add(hQuestionStackView, layoutBlock: { $0.leading().top(5).bottom(10).trailing() })
        yourQuestionView.add(questSeparatorView, layoutBlock: { $0.leading().trailing().bottom().height(1) })
        
        scrollView.add(vBaseStackView, layoutBlock: { $0.top(15).width(Constants.sW - 32).centerX() })
        scrollView.add(sendEmailButton, layoutBlock: {
            $0.topBottom(20, to: vBaseStackView).width(Constants.sW - 32).centerX().height(50).bottom()
        })
        view.add(warningImageView, layoutBlock: {
            $0.centerY(to: yourQuestionTextView).leading(10)
        })
    }
    
    fileprivate func animationMenu(constant: CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.subjectMenuView.heightConstraints.constant = constant
            self.view.layoutIfNeeded()
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

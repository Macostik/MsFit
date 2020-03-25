//  
//  SettingsSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 16.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsSceneViewController: BaseViewController<SettingsSceneViewModel> {
    
    private let userView = UserView()
    private let graphView = GraphView()
    private let measurementsView = MeasurementsView()
    
    private let scrollView = specify(UIScrollView(), {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
        userView.contactUsButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel?.presentContactUsObserver.onNext(())
            }).disposed(by: disposeBag)
        
        userView.mySettingsButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel?.presentMySettingsObserver.onNext(())
            }).disposed(by: disposeBag)
        userView.editProfileImageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [unowned self] _ in
                self.openGalery()
            }).disposed(by: disposeBag)
        measurementsView.updateMeasureButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel?.presentUpdateMeasurementObserver.onNext(())
            }).disposed(by: disposeBag)
        
        graphView.historyButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel?.presentHistoryObserver.onNext(())
            }).disposed(by: disposeBag)
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    fileprivate func addConstraints() {
        let vBaseStackView = VStackView(arrangedSubviews: [userView, graphView, measurementsView])
        
        view.add(scrollView, layoutBlock: { $0.top().width(Constants.sW).bottom(tabBarHeight) })
        scrollView.add(vBaseStackView, layoutBlock: { $0.top().bottom().width(Constants.sW) })
    }
    
    fileprivate func openGalery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension SettingsSceneViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage {
            userView.profileImageView.image = editImage
            userView.profileImageView.contentMode = .scaleAspectFill
        } else if let originImage = info[.originalImage] as? UIImage {
            userView.profileImageView.image = originImage
            userView.profileImageView.contentMode = .scaleAspectFit
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

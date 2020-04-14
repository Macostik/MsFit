//
//  EditPasswordCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EditPasswordCell: UITableViewCell, CellIdentifierable {
    
    fileprivate let disposeBag = DisposeBag()
    
    private var isShowUnshowEyes = false
    
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    
    private let titleLabel = specify(UILabel(), {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
    })
    
    private let textField = specify(UITextField(), {
        $0.placeholder = "حفظ"
        $0.returnKeyType = .done
        $0.borderStyle = .none
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        $0.isSecureTextEntry = true
    })
    
    private let eyeButton = specify(Button(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        $0.tintColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        $0.touchArea.width = 30
        $0.touchArea.height = 30
    })
    
    public func setup(with model: EditPasswordModel) {
        titleLabel.text = model.rawValue
        
        selectionStyle = .none
        backgroundColor = .systemBackground
        
        add(titleLabel, layoutBlock: { $0.leading(16).centerY() })
        add(eyeButton, layoutBlock: { $0.trailing(16).centerY().height(16).width(24) })
        add(textField, layoutBlock: {
            $0.trailingLeading(-10, to: eyeButton).centerY().leadingTrailing(10, to: titleLabel)
        })
        add(separatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
        
        setupBinding()
    }
    
    fileprivate func setupBinding() {
        textField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [unowned self] _ in
                self.textField.becomeFirstResponder()
            }).disposed(by: disposeBag)
        
        eyeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.eyeButton.setImage(self.isShowUnshowEyes ? UIImage(systemName: "eye.fill") :
                    UIImage(systemName: "eye.slash.fill"), for: .normal)
                self.textField.isSecureTextEntry.toggle()
                self.isShowUnshowEyes.toggle()
            }).disposed(by: disposeBag)
    }
}

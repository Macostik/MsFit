//
//  TipDetailsView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 23.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class TipDetailsView: UICollectionReusableView, CellIdentifierable {
    
    static var identifier: String = "TipDetailsView"
    
    private let bodyTextView = specify(UITextView(), {
        $0.textContainerInset = UIEdgeInsets(top: 0, left: 12, bottom: -16, right: 12)
        $0.textContainer.lineFragmentPadding = 0
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.tintColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.textAlignment = .left
        $0.isEditable = false
        $0.text = "🥮 So if a friend swears that munching on grapefruit gets her into skinny jeans, or 😕"
    })
        
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "food2"))
    
    private let titleLabel = specify(UILabel(), {
        $0.text = "الالتزام باشتراك أطول"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    })
    
    private let healthLabel = specify(UILabel(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.text = "الصحة"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 10, weight: .regular)
        $0.textColor = .systemBackground
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    })
    
    private let separatorView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
    })
    
    private let bottomShadowView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.shadowColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    })
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
        addConstraints()
    }
    
    func setupUI() {
        backgroundColor = .systemBackground
    }
    
    func setupBindings() {
        
    }
    
    public func setup(id: String) {
        guard let tip =
            RealmProvider.shared.realm.objects(TipsPost.self).filter({ $0.id == id }).first else { return }
        let imageURL = URL(string: tip.picture)
        imageView.sd_setImage(with: imageURL)
        titleLabel.text = tip.title
        healthLabel.text = tip.category
    }
    
    func addConstraints() {
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        healthLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        healthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let titleVStackView = VStackView(arrangedSubviews: [
            imageView, titleLabel,
            HStackView(arrangedSubviews: [healthLabel, UIView()]),
            separatorView, bodyTextView
            ], spacing: 16)
        
        add(imageView, layoutBlock: { $0.top().leading().trailing().height(Constants.sW * 0.9) })
        add(titleVStackView, layoutBlock: {
            $0.topBottom(16, to: imageView).leading(16).trailing(16).bottom(50)
        })
        add(bottomShadowView, layoutBlock: { $0.bottom().leading().trailing().height(30) })
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

//extension TipDetailsView {
//    private func addTextView(attributedString: NSMutableAttributedString, indent: CGFloat = 0.0 ) {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.maximumLineHeight = 20.0
//        paragraphStyle.alignment = .left
//        paragraphStyle.lineSpacing = 2.7
//        paragraphStyle.firstLineHeadIndent = indent
//        paragraphStyle.headIndent = indent > 0 ? indent + 16 : indent
//        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle],
//                                       range: NSRange(location: 0, length: attributedString.length))
//        bodyTextView.delegate = self
//        bodyTextView.linkTextAttributes = convertToOptionalNSAttributedStringKeyDictionary(
//            [NSAttributedString.Key.foregroundColor.rawValue: #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1),
//             NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 16)
//        ])
//        attributedString
//            .enumerateAttributes(in: NSRange(0..<attributedString.length),
//                                 options: .reverse) { attributes, range, _ in
//                                       if let attString = attributes[NSAttributedString.Key.link] as? URL
//                                           attString.absoluteString.contains(Constants.toolTip) {
//                                           attributedString.addAttributes(
//                                               [NSAttributedString.Key.underlineColor : UIColor.clear,
//                                                NSAttributedString.Key.baselineOffset : -3],
//                                               range: range)}
//                                    bodyTextView.attributedText = attributedString
//        }
           
//           let lastView = bodyView.arrangedSubviews.last
//           bodyView.addArrangedSubview(contentTextView)
//           guard let previousView = lastView else { return }
//           if indent > 0 {
//               previousIndent = indent
//               bodyView.setCustomSpacing(10, after: previousView)
//           } else if previousIndent > 0 {
//               previousIndent = 0
//               bodyView.setCustomSpacing(10, after: previousView)
//           } else  {
//               bodyView.setCustomSpacing(25, after: previousView)
//           }
//       }
//
//    private func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) ->
//        [NSAttributedString.Key: Any]? {
//            guard let input = input else { return nil }
//            return Dictionary(uniqueKeysWithValues: input.map { key, value in
//                (NSAttributedString.Key(rawValue: key), value)})
//    }
//}

//extension TipDetailsView: UITextViewDelegate {
//    func textView(_ textView: UITextView,
//                  shouldInteractWith URL: URL,
//                  in characterRange: NSRange,
//                  interaction: UITextItemInteraction) -> Bool {
//        switch interaction {
//        case .invokeDefaultAction:
//            if textView.gestureRecognizers?
//                .contains(where: {$0.isKind(of: UITapGestureRecognizer.self) && $0.state == .ended}) == true {
//                if !URL.absoluteString.contains(Constants.toolTip) { return true }
//                let popupView = PopupView<ContainerView>()
//                let textRange = characterRange.toTextRange(textInput: textView)
//                let rect = textView.firstRect(for: textRange!)
//                let sourceView = UIView(frame: rect)
//                let originRect = convert(rect, from: textView)
//                sourceView.frame = originRect
//                add(sourceView)
//                do {
//                    let realm = try Realm()
//                    guard let id = URL["id"],
//                        let text = realm.objects(ToolTip.self).filter({$0.id == id}).first?.body
//                        else { return false }
//                    popupView.showInView(view,
//                                         sourceView: sourceView,
//                                         text: text,
//                                         cancel: { [weak sourceView] in
//                                            sourceView?.removeFromSuperview()
//                    })
//                } catch {}
//
//                return false
//            }
//            return true
//        case .presentActions:
//            return false
//        case .preview:
//            return true
//        @unknown default:
//            fatalError()
//        }
//    }
//}

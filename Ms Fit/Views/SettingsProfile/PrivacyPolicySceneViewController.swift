//  
//  PrivacyPolicySceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 14.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PrivacyPolicySceneViewController: BaseViewController<PrivacyPolicySceneViewModel> {
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "سياسة الخصوصية"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private lazy var pravicyTextTextView = specify(UITextView(), {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let attributes = [NSAttributedString.Key.paragraphStyle: style]
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.showsVerticalScrollIndicator = false
        $0.attributedText = NSAttributedString(string: "Many critics have attacked the efficacy and legitimacy of privacy policies found on the Internet. Concerns exist about the effectiveness of industry-regulated privacy policies. For example, a 2000 FTC report Privacy Online: Fair Information Practices in the Electronic Marketplace found that while the vast majority of websites surveyed had some manner of privacy disclosure, most did not meet the standard set in the FTC Principles. In addition, many organizations reserve the express right to unilaterally change the terms of their policies. In June 2009 the EFF website TOSback began tracking such changes on 56 popular internet services, including monitoring the privacy policies of Amazon, Google and Facebook. There are also questions about whether consumers understand privacy policies and whether they help consumers make more informed decisions. A 2002 report from the Stanford Persuasive Technology Lab contended that a website's visual designs had more influence than the website's privacy policy when consumers assessed the website's credibility. A 2007 study by Carnegie Mellon University claimed when not presented with prominent privacy information... consumers were likely to make purchases from the vendor with the lowest price, regardless of that site's privacy policies. However, the same study also showed that when information about privacy practices is clearly presented, consumers prefer retailers who better protect their privacy and some are willing to pay a premium to purchase from more privacy protective websites. Furthermore, a 2007 study at the University of California, Berkeley found that 75% of consumers think as long as a site has a privacy policy it means it won't share data with third parties, confusing the existence of a privacy policy with extensive privacy protection. Privacy policies suffer generally from a lack of precision, especially when compared with the emerging form of the Data Use Statement. Where privacy statements provide a more general overview of data collection and use, data use statements represent a much more specific treatment. As a result, privacy policies may not meet the increased demand for transparency that data use statements provide. Critics also question if consumers even read privacy policies or can understand what they read. A 2001 study by the Privacy Leadership Initiative claimed only 3% of consumers read privacy policies carefully, and 64% briefly glanced at, or never read, privacy policies. The average website user once having read a privacy statement may have more uncertainty about the trustworthiness of the website than 2008 Carnegie Mellon study, the average length of a privacy policy is 2,500 words and requires an average of 10 minutes to read. The study cited that Privacy policies are hard to read and, as a result, read infrequently. However, any efforts to make the information more presentable simplify the information to the point that it does not convey the extent to which users' data is being shared and sold.[53] This is known as the 'transparency paradox. It is also believed that for proper privacy to be offered by service providers, it is not enough to force transparency through regulation, but it is also essential to have viable alternatives, so that the Internet services market (such as that of social networks) can operate like a free market where choices can be made by consumers", attributes: attributes)
        $0.contentInset = .init(top: 16, left: 0, bottom: -16, right: 0)
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
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
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : Constants.sH_667 ? 80 : 70)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(Constants.sH_667 ? 15 : 5) })
        navigationView.add(closeButton, layoutBlock: { $0.centerY(to: navTextLabel).leading(4).size(44) })
        view.add(pravicyTextTextView, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing().bottom()
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

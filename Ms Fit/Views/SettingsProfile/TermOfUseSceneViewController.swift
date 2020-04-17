//  
//  TermOfUseSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 14.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TermOfUseSceneViewController: BaseViewController<TermOfUseSceneViewModel> {
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "شروط الاستخدام"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    private lazy var closeButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "chevron.left", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
    })
    
    private let termOfUseTextView = specify(UITextView(), {
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.showsVerticalScrollIndicator = false
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.textAlignment = .right
        $0.text = """
        1 - في حال واجهتك مشكلة في الدفع ( تم خصم المبلغ ولم يتم تفعيل العضوية ) يمكنك التواصل معنا على
        حساب انستقرام msfit.sa  عن طريق الرسائل الخاصة وسيتم حل المشكلة خلال 24 ساعة كحد أقصى.
        2 - البرامج المصممة لا تناسب من يعانون من أمراض مزمنة على سبيل المثال لا الحصر..
        السكري.. الروماتيزيوم والربو الحاد .. وغيرها من الأمراض أو الإصابات أو
        العمليات الجراحية التي تسبب خطرا على من يمارس الرياضة
        3 - لا تتحمل مؤسسة اللمسة الذكية لتقنية المعلومات والتي تحمل سجل تجاري رقم 1010701755
        والمالكة للتطبيق أي  مسؤولية تجاه الإصابات التي تنتج من أداء
        التمارين بشكل خاطئ ويجب مراجعة الطبيب عند حدوث ذلك لا قدر الله
     4 - البرامج الغذائية مصممة بمرونة لتناسب اكبر شريحة معينة ويمكنك اختيار ما
        يناسب احتياجك اليومي من السعرات للحصول على نتائج أفضل.
        5 - البرامج الرياضية تم تصميمها من قبل مدربات متخصصات لتناسب جميع الفئات وفي حال
        عدم حصولك على النتيجة المرجوة فهذا يعني أن طبيعة جسمك لا تناسب هذا
        البرنامج وربما تحتاجين إلى تدريب شخصي..ولا نتحمل مسؤولية ذلك
   6 - في حالة شعورك بألم أو ضرر صحي عند ممارسة الرياضة أو عند اتباع انظمتنا
        الغذائية عليك مراجعة الطبيب وشرح الحالة كاملة له ولا نتحمل أي مسؤولية تنتج عن مثل هذه الحالات..
        7- لا تناسب هذه التمارين المرأة الحامل.
        8- يقدم التطبيق فترة تجربة 3 أيام لكل من مستخدم لذلك سياسة الاسترجاع صارمة
        ولا يمكن قبولها وفي حالة حدوث خطأ تقني يتم تعويض المشترك بمدة
        اشتراك تناسب عدد الأيام التي تعطل فيها التطبيق عن العمل
        9 - يجب أن لايقل عمر المشتركة عن 18 سنة ولا يزيد عن 45 سنة حتى تحصل على نتئائج
        مرضية وفعالة وتتجنب الإصابات
         10 - للشركة الحق في تعديل سعر الاشتراكات متى ما رغبت وسيتم اعلان السعر
        الجديد على شاشة الاشتراك داخل التطبيق ,وسيشمل السعر الجديد الاشتراكات الجديدة فقط.
   11 - تسجيلك واشتراكك في أحد البرامج الرياضية بهذا التطبيق يعني
        أنك موافقة على كافة الشروط والأحكام الخاصة بالتطبيق.
   12 - في حال استخدامك لبريد وهمي، لا نتحمل أي مسؤولية عن أي خلل يواجهك داخل
        التطبيق لعدم قدرتنا على التواصل معك.
"""
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
        view.add(termOfUseTextView, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing().bottom() })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

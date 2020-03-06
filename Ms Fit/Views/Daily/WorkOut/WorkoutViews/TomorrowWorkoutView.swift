//
//  TomorrowWorkoutView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 05.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

typealias TomorrowWorkoutDataSource = RxCollectionViewSectionedReloadDataSource<TomorrowWorkoutSceneModel>

class TomorrowWorkoutView: UIView {
    
    fileprivate let disposeBag = DisposeBag()
    
    private lazy var dataSource: TomorrowWorkoutDataSource = {
        return TomorrowWorkoutDataSource(configureCell: {  _, collectionView, indexPath, data in
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: TomorrowWorkoutCell.identifier,
                                     for: indexPath) as? TomorrowWorkoutCell else { fatalError() }
            cell.setup(exercise: data)
            return cell
        })
    }()
    
    private let containerForButtonsView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
    })
    
    private let separatorView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
        $0.layer.shadowColor = #colorLiteral(red: 0.4309999943, green: 0.4309999943, blue: 0.474999994, alpha: 1)
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = .init(width: 0, height: 4)
    })
    
    private let containerForExercisesView = specify(UIView(), {
        $0.backgroundColor = .systemBackground
    })
    
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .thin)
    private lazy var startWorkoutButton = specify(UIButton(type: .roundedRect), {
        $0.setImage(UIImage(systemName: "play.fill", withConfiguration: mediumConfiguration)?
            .withTintColor(.systemBackground, renderingMode: .alwaysOriginal), for: .normal)
        $0.customButton(text: "Start Workout", font: 20, weight: .bold, shadowColor: #colorLiteral(red: 0.5019999743, green: 0.3330000043, blue: 0.8709999919, alpha: 1), bgColor: #colorLiteral(red: 0.5019999743, green: 0.3330000043, blue: 0.8709999919, alpha: 1))
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 16)
    })
    
    private let hExercisesStackView = specify(UIStackView(), {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 2
    })
    
    private let minutesLabel = specify(UILabel(), {
        $0.text = "minutes"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    })
    
    private let timeLabel = specify(UILabel(), {
        $0.text = "60"
        $0.textColor = #colorLiteral(red: 0.1490000039, green: 0.1490000039, blue: 0.1689999998, alpha: 1)
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    })
    
    private let clockImageView = specify(UIImageView(), {
        $0.image = UIImage(systemName: "clock",
                           withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        $0.tintColor = #colorLiteral(red: 0.4079999924, green: 0.2980000079, blue: 0.8159999847, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 15)
        let size = Constants.sW/2 - 22
        layout.itemSize = CGSize(width: size, height: size - 15)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TomorrowWorkoutCell.self,
                                forCellWithReuseIdentifier: TomorrowWorkoutCell.identifier)
        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        collectionView.scrollIndicatorInsets = .init(top: 15, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addConstraint()
    }
    
    fileprivate func setupUI() {
        let section = [TomorrowWorkoutSceneModel(items: TomorrowWorkoutList.allCases)]
        Observable.just(section)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        startWorkoutButton.animateWhenPressed(disposeBag: disposeBag)
        startWorkoutButton.rx.tap
            .subscribe(onNext: {
                // do something
            }).disposed(by: disposeBag)
    }
    
    fileprivate func addConstraint() {
        clockImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        clockImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        hExercisesStackView.addArrangedSubview(minutesLabel)
        hExercisesStackView.addArrangedSubview(timeLabel)
        hExercisesStackView.addArrangedSubview(clockImageView)
        add(containerForButtonsView, layoutBlock: {
            $0.bottom().leading().trailing().height(Constants.sH_812 ? 110 : Constants.sH_667 ? 90 : 80)
        })
        containerForButtonsView.add(startWorkoutButton, layoutBlock: {
            $0.top(15).width(Constants.sW - 32).height(Constants.sW / 6.5).centerX()
        })
        add(containerForExercisesView, layoutBlock: {
            $0.top(10).leading().trailing().height(Constants.sH_812 ? 70 : Constants.sH_667 ? 50 : 40)
        })
        containerForExercisesView.add(hExercisesStackView, layoutBlock: { $0.centerX().centerY(5) })
        add(collectionView, layoutBlock: {
            $0.topBottom(to: containerForExercisesView)
                .leading().trailing().bottomTop(to: containerForButtonsView) //the mistake here
        })
        add(separatorView, layoutBlock: {
            $0.leading().trailing().height(10).topBottom(to: containerForExercisesView)
        })
    }
    
    required init?(coder: NSCoder) { fatalError("has not been implemented meals table view") }
}

//  
//  ExercisesSceneViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 22.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct Exercises: Decodable, Hashable {
    let image, text: String
}

class ExercisesSceneViewController: BaseViewController<ExercisesSceneViewModel> {
    
    private let exerciseModels = [
        Exercises(image: "arm_image", text: "Arm"),
        Exercises(image: "abs_image", text: "Abs"),
        Exercises(image: "cardio_image", text: "Cardio"),
        Exercises(image: "1_image", text: "Back"),
        Exercises(image: "legs_image", text: "Legs"),
        Exercises(image: "chest_image", text: "Chest"),
        Exercises(image: "shoulder_image", text: "Shoulder"),
        Exercises(image: "waist_image", text: "Complex")
    ]
    
    private var collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    
    private let navigationView = specify(UIView(), {
        $0.backgroundColor = #colorLiteral(red: 0.5329999924, green: 0.3490000069, blue: 0.8899999857, alpha: 1)
        $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    })
    
    private let navTextLabel = specify(UILabel(), {
        $0.text = "Exercises"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .systemBackground
    })
    
    override func setupUI() {
        handleUI()
        addConstraints()
    }
    
    override func setupBindings() {
    }
    
    fileprivate func handleUI() {
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        view.transform = CGAffineTransform(scaleX: -1, y: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        addCollectionView()
    }
    
    fileprivate func addConstraints() {
        view.add(navigationView, layoutBlock: {
            $0.leading().trailing().top().height(Constants.sH_812 ? 100 : 80)
        })
        navigationView.add(navTextLabel, layoutBlock: { $0.centerX().bottom(5) })
        view.add(collectionView, layoutBlock: {
            $0.topBottom(to: navigationView).leading().trailing().bottom(tabBarHeight)
        })
    }
    
    fileprivate func addCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        collectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: ExerciseCell.reuseId)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}

extension ExercisesSceneViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exerciseModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCell.reuseId,
                                                      for: indexPath) as! ExerciseCell
        let exercise = exerciseModels[indexPath.row]
        cell.setup(exercise: exercise)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftRightPadding = view.frame.width * 0.01
        let insetSpacing = view.frame.width * 0.01
        let cellWidth = (view.frame.width - 2 * leftRightPadding - 2 * insetSpacing) / 2

        return .init(width: cellWidth - 10, height: cellWidth - 10)
    }
}

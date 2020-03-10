//
//  MealHeaderView.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 10.03.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class MealHeaderView: UICollectionReusableView, CellIdentifierable {
    
    static var identifier: String = "MealHeaderView"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented MealHeaderView")
    }
    
}

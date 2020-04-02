//
//  SettingsCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 02.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell, CellIdentifierable {
    
    let tosSwitch = specify(UISwitch(), {
        $0.isOn = true
    })
    let accessoryLabel = UILabel()
    
    func setup(setting: SettingsStorageSceneModel) {
        selectionStyle = .none
        textLabel?.text = setting.description().0
        add(accessoryLabel, layoutBlock: { $0.centerY().trailing(40) })
        accessoryLabel.text = setting.description().1
        if setting == .logOut {
            textLabel?.textAlignment = .center
            textLabel?.textColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1)
        } else if setting == .termOfUse {
            add(tosSwitch, layoutBlock: { $0.centerY().trailing(20) })
        } else {
            accessoryType = .disclosureIndicator
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tosSwitch.removeFromSuperview()
        accessoryLabel.removeFromSuperview()
        textLabel?.text = nil
        textLabel?.textAlignment = .left
        accessoryType = .none
        textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

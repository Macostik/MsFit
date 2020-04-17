//
//  SettingsCell.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 02.04.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell, CellIdentifierable {
    
    private let tosSwitch = specify(UISwitch(), {
        $0.isOn = true
    })
    
    private let separatorView = specify(UIView(), { $0.backgroundColor = #colorLiteral(red: 0.9369999766, green: 0.9369999766, blue: 0.9369999766, alpha: 1) })
    private let accessoryLabel = UILabel()
    
    public func setup(setting: SettingsStorageSceneModel) {
        selectionStyle = .none
        textLabel?.text = setting.description().0
        textLabel?.textAlignment = .right
        
        add(separatorView, layoutBlock: { $0.leading().bottom().trailing().height(1) })
        add(accessoryLabel, layoutBlock: { $0.centerY().trailing(40) })
        
        accessoryLabel.text = setting.description().1
        accessoryLabel.textColor = #colorLiteral(red: 0.6159999967, green: 0.6159999967, blue: 0.6669999957, alpha: 1)
        if setting == .logOut {
            textLabel?.textAlignment = .center
            textLabel?.textColor = #colorLiteral(red: 0.968627451, green: 0.1843137255, blue: 0.4117647059, alpha: 1)
        } else if setting == .notification {
            add(tosSwitch, layoutBlock: { $0.centerY().trailing(20) })
        } else {
            accessoryType = .disclosureIndicator
            if setting == .version || setting == .notification {
                accessoryType = .none
            }
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

//
//  CellExtension.swift
//  Ostazi Profile
//
//  Created by Islam Elshazly on 4/10/18.
//  Copyright © 2018 Karshless. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func enable(on: Bool) {
        for view in contentView.subviews {
            view.isUserInteractionEnabled = on
            view.alpha = on ? 1 : 0.5
        }
    }
}

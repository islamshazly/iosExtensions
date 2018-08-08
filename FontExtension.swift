//
//  FontExtension.swift
//  Twigano
//
//  Created by mac on 8/2/17.
//  Copyright © 2017 islam elshazly. All rights reserved.
//

import UIKit

extension UIFont {
    class func O_CairoRegular(_ size: CGFloat) -> (UIFont?) {
        return UIFont(name: "Cairo-Regular", size: size)
    }
    
    class func O_CairoBold(_ size: CGFloat) -> (UIFont?) {
        return UIFont(name: "Cairo-Bold", size: size)
    }
}

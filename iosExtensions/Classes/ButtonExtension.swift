//
//  UIButtonExtension.swift
//  Baheeg
//
//  Created by Islam Elshazly on 5/24/18.
//  Copyright © 2018 krashless.com. All rights reserved.
//

import UIKit


extension UIButton {
    func disable() {
        self.isEnabled = false
        self.alpha = 0.5
    }
    
    func enable() {
        self.isEnabled = true
        self.alpha = 1.0
    }
    
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.imageView?.isHidden = true
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            indicator.color = .black
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.imageView?.isHidden = false
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
    
    func imageWith(color:UIColor, for: UIControlState) {
        if let imageForState = self.image(for: state) {
            self.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
            let colorizedImage = imageForState.image(withTintColor: color)
            self.setImage(colorizedImage, for: state)
            self.tintColor = color
        }
    }
    
    func centerTextAndImage(spacing: CGFloat) {
        var insetAmount = spacing / 2
        insetAmount = Language.language == Language.arabic ? -1 * insetAmount : 1 * insetAmount
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    
}


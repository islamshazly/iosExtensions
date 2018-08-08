//
//  UITextFieldExtension.swift
//  Twigano
//
//  Created by islam elshazly on 9/17/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

extension UITextField {
  func increaseFontSize(by: CGFloat) {
    self.font =  UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)!+by)!
  }
}

//
//  UITabBarControllerExtension.swift
//  Twigano
//
//  Created by islam elshazly on 8/1/17.
//  Copyright © 2017 islam elshazly. All rights reserved.
//

import UIKit

extension UITabBarController {
  func removeTabbarItemsText() {
    tabBar.items?.forEach {
      $0.title = ""
      $0.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
  }
  
  func changeUnselectedItemColor(to unselectedColor: UIColor) {
    tabBar.items?.forEach {
        if ($0.selectedImage?.with(color: unselectedColor).withRenderingMode(.alwaysOriginal) as? UIImage) != nil{
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : unselectedColor], for: .normal)
        } else {
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : unselectedColor], for: .normal)
        }
    }
    
    }
  
  func changeSelectedItemColor(to selectedColor: UIColor) {
    tabBar.tintColor = selectedColor
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : selectedColor], for: .selected)
  }
  
  func changeSelectedItemBackgroundColor(to backgroundColor: UIColor) {
    let numberOfItems = CGFloat(tabBar.items!.count)
    
    let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems,
                                height: tabBar.frame.height)
    
    tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: backgroundColor, size: tabBarItemSize).resizableImage(withCapInsets: .zero)
    
    tabBar.frame.size.width = self.view.frame.width + 4
    tabBar.frame.origin.x = -2
  }
}

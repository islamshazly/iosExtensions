//
//  UIViewControllerExtension.swift
//
//
//  Created by islam elshazly on 8/6/17.
//  Copyright © 2017 islam elshazly. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func viewController(withStoryBoardname storyBoardName : String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyBoardName, bundle: .main)
        let controller = storyboard.instantiateInitialViewController()
        return controller
    }
    
    static func viewController(withStoryBoardname storyBoardName : String , contollerID : String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyBoardName, bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: contollerID)
        return controller
    }
    
    class func openURL(stringURL : String) {
        let url: NSURL = URL(string: stringURL)! as NSURL
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    
    class var topMostViewController: UIViewController {
        let root = UIApplication.shared.keyWindow?.rootViewController
        return self.topMostViewControllerWithRootViewController(root: root!)
    }
    
    class func topMostViewControllerWithRootViewController(root: UIViewController) -> UIViewController {
        if let tab = root as? UITabBarController {
            return self.topMostViewControllerWithRootViewController(root: tab.selectedViewController!)
        }
        if let nav = root as? UINavigationController {
            return self.topMostViewControllerWithRootViewController(root: nav.visibleViewController!)
        }
        if let presented = root.presentedViewController {
            return self.topMostViewControllerWithRootViewController(root: presented)
        }

        return root
    }
    
    func isModal() -> Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
}

//
//  UIViewControllerExtension.swift
//  Twigano
//
//  Created by islam elshazly on 8/6/17.
//  Copyright © 2017 islam elshazly. All rights reserved.
//

import UIKit
import XLPagerTabStrip

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
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
    }
    
    
    class func presentLogin(_ ViewController : UIViewController) {
        
        let loginVC = UIViewController.viewController(withStoryBoardname: LoginStoryBoard.name)
        
        ViewController.present(loginVC!, animated: true) {
            //
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
        
        // We are at the root
        return root
    }
    
    func isModal() -> Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
    
    
    //MARK: - for baheega app
    
    class func  presentUploadVideo(_ viewController : UIViewController) {
        if let addVideoNC = UIViewController.viewController(withStoryBoardname: AddStoryBoard.name, contollerID: AddStoryBoard.AddYouTubeNC) as? UINavigationController {
            viewController.present(addVideoNC, animated: true, completion: nil)
        }
    }
    
    class func  presentUploadImageURL(_ viewController : UIViewController , imageType : ImageType?) {
        if let addImageNC = UIViewController.viewController(withStoryBoardname: AddStoryBoard.name, contollerID: AddStoryBoard.AddImageURLNC) as? UINavigationController {
            let addImageVC = addImageNC.viewControllers.first as? AddImageURLVC
            addImageVC?.imageType = imageType
            viewController.present(addImageNC, animated: true, completion: nil)
        }
    }

    class func presentSinglePostNav(WithPost post : PostModel , viewController : UIViewController , delegate : PostCellDelegate?) {
        
        let singlePostNC = UIViewController.viewController(withStoryBoardname: HomeStoryBoard.name, contollerID: HomeStoryBoard.SinglePostNC) as? UINavigationController
        let singlePostVC = singlePostNC?.viewControllers.first as? SinglePostVC
        singlePostVC?.post = post
        singlePostVC?.delegate = delegate
        viewController.present(singlePostNC!, animated: true, completion: nil)
    }
    
    class func presentSinglePostNav(WithPostKey key : String , viewController : UIViewController ) {
        
        let singlePostNC = UIViewController.viewController(withStoryBoardname: HomeStoryBoard.name, contollerID: HomeStoryBoard.SinglePostNC) as? UINavigationController
        let singlePostVC = singlePostNC?.viewControllers.first as? SinglePostVC
        singlePostVC?.postKey = key
        viewController.present(singlePostNC!, animated: true, completion: nil)
    }
    
    class func presentSinglePost(WithPost post : PostModel , viewController : UIViewController , delegate : PostCellDelegate?) {
        
        let singlePostVC = UIViewController.viewController(withStoryBoardname: HomeStoryBoard.name, contollerID: HomeStoryBoard.SinglePostVC) as? SinglePostVC
        singlePostVC?.post = post
        singlePostVC?.delegate = delegate
        viewController.present(singlePostVC!, animated: true, completion: nil)
        
    }
    
    class func goToUserProfile(withUser user : UserModel , viewController : UIViewController , delegete : followCellDelegate? , cellDelegate : PostCellDelegate?) {
        
        if let userProfileVC = UIViewController.viewController(withStoryBoardname: KingsStoryBoard.name, contollerID: KingsStoryBoard.UserPostsVC) as? UserPostsVC {
            userProfileVC.user = user
            userProfileVC.delegate = delegete
            userProfileVC.postcellDelegate = cellDelegate
            viewController.navigationController?.pushViewController(userProfileVC, animated: true)
//            viewController.present(userProfileVC, animated: true, completion: nil)
        }
    }
    
    class func gotToUsers(viewController: UIViewController, title: String, userList: UsersListApiCall, user: UserModel?) {
        
        let userVC = UIViewController.viewController(withStoryBoardname: KingsStoryBoard.name, contollerID: KingsStoryBoard.TopMotnthUsersVC) as? TopUsersVC
        userVC?.itemInfo = IndicatorInfo(title: title)
        userVC?.usersList = userList
        if user != nil {
            
            userVC?.user = user!
        }
        viewController.navigationController?.pushViewController(userVC!, animated: true)
    }
    
    class func presentProfile(withUser user : UserModel , viewController : UIViewController , delegete : followCellDelegate?) {
        
        if let userProfileNC = UIViewController.viewController(withStoryBoardname: KingsStoryBoard.name, contollerID: KingsStoryBoard.UserPostsNC) as? UINavigationController {
            let userProfileVC = userProfileNC.viewControllers.first as? UserPostsVC
            userProfileVC?.user = user
            userProfileVC?.delegate = delegete
            viewController.present(userProfileNC, animated: true, completion: nil)
            //            viewController.present(userProfileVC, animated: true, completion: nil)
        }
    }
    
    class func goToComments(controller: UIViewController , post: PostModel) {
        
        if let commentVC = UIViewController.viewController(withStoryBoardname: HomeStoryBoard.name, contollerID: HomeStoryBoard.CommentVC) as? CommentVC {
            commentVC.post = post
            controller.navigationController?.pushViewController(commentVC, animated: true)
        }
    }
    
    class func goToRoot() {
        
        let rootVC = UIViewController.viewController(withStoryBoardname: RootStoryBoard.name)
        appDelegate?.window?.rootViewController = rootVC
    }
    
    
    class func singlePostVC(post: PostModel) -> UINavigationController{
        
        let sinlgeNC = UIViewController.viewController(withStoryBoardname: HomeStoryBoard.name, contollerID: HomeStoryBoard.SinglePostNC) as? UINavigationController
        let sinlgeVC = sinlgeNC?.viewControllers.first as? SinglePostVC
        sinlgeVC?.post = post
        
        return sinlgeNC!
    }
    
    class func presentImageViewer(viewcontroller: UIViewController, image: UIImage, title: String) {
        
        let imageViewerNC = UIViewController.viewController(withStoryBoardname: "ImageViewer") as? UINavigationController
        let imageViewerVC = imageViewerNC?.viewControllers.first as? ImageViewerVC
        imageViewerVC!.profileImage = image
        imageViewerVC?.username = title
        viewcontroller.present(imageViewerNC!, animated: true, completion: nil)
    }
  
}

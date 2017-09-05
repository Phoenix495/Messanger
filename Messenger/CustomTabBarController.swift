//
//  CustomTabBarController.swift
//  Messenger
//
//  Created by Phoenix on 14.06.17.
//  Copyright © 2017 Phoenix. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // настройка view controllers
        
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentsMessagesController = UINavigationController(rootViewController: friendsController)
        recentsMessagesController.tabBarItem.title = "Recents"
        recentsMessagesController.tabBarItem.image = UIImage(named: "recents")
        
        viewControllers = [recentsMessagesController,
                           createDummyNavControllerWithTitle(title: "Calls", imageName: "calls"),
                           createDummyNavControllerWithTitle(title: "Groups", imageName: "groups"),
                           createDummyNavControllerWithTitle(title: "People", imageName: "people"),
                           createDummyNavControllerWithTitle(title: "Setings", imageName: "settings")]
        
    }
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}

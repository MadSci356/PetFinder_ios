//
//  MasterTabViewController.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/9/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import UIKit

/**
 Icons made by https://www.flaticon.com/authors/freepik at
 https://www.flaticon.com/ is licensed by
 http://creativecommons.org/licenses/by/3.0/
 */
class MasterTabViewController: UITabBarController, MetaControllerConsumer {
    
    var metaController: MetaController? {
        didSet {
            guard let viewControllers = viewControllers else {
                return
            }
            // in case a VC starts before its meta controller or vice versa
            for viewController in viewControllers {
                passMetaController(viewController)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchVC = ViewControllerFactory.searchTableView(metaController: metaController)
        let typesVC = ViewControllerFactory.typesTableView(metaController: metaController)
        
        //tab bar items
        let clownFish = UIImage(named: "clown-fish")
        
        typesVC.tabBarItem = UITabBarItem(title: "Pet Types", image: clownFish, selectedImage: clownFish)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        selectedIndex = 0
        //set viewController here later when more tabs required
        viewControllers = [UINavigationController(rootViewController: searchVC),
                            UINavigationController(rootViewController: typesVC)]
    }

}

//
//  AppDelegate.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/4/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    ///all the meta controller components will get initialized here
    let appManager = AppManager()
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //main view controller that will appear when app starts
        let masterVC = ViewControllerFactory.masterTabView(metaController: appManager.metaController)
        
        //making the main view appear in front
        window?.rootViewController = masterVC
        window?.makeKeyAndVisible()
        
        //starting specific things that can't be started otherwise
        appManager.start()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        appManager.stop()
    }
}

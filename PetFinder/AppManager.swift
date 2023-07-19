//
//  AppManager.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/25/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

/**
    All the vars this app's metaController will be initialized by AppManager.
    AppManager will be used in AppDelegate
 */
class AppManager: MetaControllerConsumer {
    
    ///This app's meta controller that will be initialized when AppManager is created in AppDelegate
    var metaController: MetaController?
    
    /// Intializes the vars in the MetaController
    init() {
        
        //the main man metaController
        metaController = MetaController()
        
        //now setting all the vars within metaController
        metaController?.logController = LogController(metaController: metaController)
        // start up the log controller
        metaController?.logController?.start()
        metaController?.apiController = ApiController(metaController: metaController)
        metaController?.userController = UserController(metaController: metaController)
        metaController?.dataController = DataController(metaController: metaController)
    }
    
    /**
     t = 0. Set up for the app
    */
    func start() {
        mUser?.start()
    }
    
    /**
     This is Not the End.
    */
    func stop() {
       mLog?.stop()
        
    }
}

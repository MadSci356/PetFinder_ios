//
//  UserController.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/9/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    /// notification for token received
    static let didReceiveToken = Notification.Name("AuthTokenReceived")
}

class UserController: MetaControllerConsumer {
    
    var metaController: MetaController?
    var token: AuthToken?
    
    init (metaController: MetaController?) {
        self.metaController = metaController
        
    }
    
    func start() {
        if token == nil {
            requestToken()
        }
    }
    
    /**
        Requests a token from PetFinder API
    */
    func requestToken () {
        let tokenResource = AuthToken.resource
        
        infoLog("Requesting Access to get a token")
        
        mApi?.load(resource: tokenResource) { tokenResult in
            switch tokenResult {
            case .success(let authToken):
                
                self.mApi?.addAuthToken(authToken: authToken)
                
                self.verboseLog("sending notification that token is received")
                //notify petfinder task so it can load data
                NotificationCenter.default.post(name: .didReceiveToken, object: self)
                self.verboseLog("Notification sent for auth token reception.")
                
                //set token in Api Controller
                self.token = authToken
                
            case .failure(let error):
                self.errorLog("Did not receive valid token, \(error.errorText)")
            }
        }
        
    }

}

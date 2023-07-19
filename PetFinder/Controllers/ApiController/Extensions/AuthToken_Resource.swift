//
//  AuthToken_Resources.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/8/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

extension AuthToken {
    
    /**
     This extension allows the use of Resource in ApiController.load().
     Generates an Auth resource with the credentials.
     
     - Returns: Resource<Auth> configured to call the PetFinder-v2
     and ask for a valid token
     */
    static var resource: Resource<AuthToken> {
        
        //url and string login data for getting a token
        let requestTokenUrl = URL(string: "https://api.petfinder.com/v2/oauth2/token")! //swiftlint:disable:this force_unwrapping line_length
        let clientID =  "&client_id=6GKm9rtXgxRUHJmp32wQhsW70b5lS8lfd13jWl2WJM4hpcwr30"
        let secretKey = "&client_secret=GVXoK11nZ15fJUdj8akAfAXmDSLuNjrDLZ6wBFE2"
        let tokenBody = "grant_type=client_credentials" + clientID + secretKey
        
        //making the parse closure for Auth token
        let parseData = {
            (data: Data) -> AuthToken? in
            let decoder = JSONDecoder()
            let authToken = try? decoder.decode(AuthToken.self, from: data)
            return authToken
        }
        
        let resource = Resource<AuthToken>(url: requestTokenUrl, method: .post, body: tokenBody, parse: parseData)
        
        return resource
    }
}

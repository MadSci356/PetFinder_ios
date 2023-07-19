//
//  AuthToken_Resources.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/8/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

//extension AccessToken {
//
//    /**
//     This extension allows the use of Resource in RestCall.load().
//     Generates an AccessToken resource with the credentials.
//
//     - Returns: Resource<AccessToken> configured to call the PetFinder-v2
//     and ask for a valid token
//     */
//    static var resource: Resource<AccessToken> {
//
//        //url and string login data for getting a token
//        let requestTokenUrl = URL(string: "https://api.petfinder.com/v2/oauth2/token")! //swiftlint:disable:this force_unwrapping line_length
//        let clientID =  "&client_id=F2IB7H88duU79yTfnGU0Ssvt3FPAfTKvI395Yq3WPMu6ypgryh"
//        let secretKey = "&client_secret=Ah5tEkQ51ryhYu3rx6748EKCSsSHc3YJXabeGUf8"
//        let tokenBody = "grant_type=client_credentials" + clientID + secretKey
//
//        //making the parse closure for access token
//        let parseData = {
//            (data: Data) -> AccessToken? in
//            let decoder = JSONDecoder()
//            let accessToken = try? decoder.decode(AccessToken.self, from: data)
//            return accessToken
//        }
//
//        let resource = Resource<AccessToken>(url: requestTokenUrl, method: .post, body: tokenBody, parse: parseData)
//
//        return resource
//    }
//}

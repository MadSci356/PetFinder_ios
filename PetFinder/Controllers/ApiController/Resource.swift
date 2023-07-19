//
//  Resource.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/26/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

/// Makes selecting type of http requests better
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

/**
 ### Makes it easier to configure Rest calls.
 Each kind (Type) of a network call can have it's own formula for configuring the various things that go into REST calls
 These include: url, body, headers fields etc.
 
 ### Resource abstracts out those configuration params so that you can have custom versions for each type of resource.
 For example: an auth token Resource will be pre-configured with http body that
 will ask the API for a token with a POST call.
 Then, a PetFinder Resource will be use that result to configure itself with an auth token to make a GET call
 */
struct Resource<Type> {
    
    /// address where this network call should be made
    let url: URL
    /// queries to add to the url address
    let queryParams: [String: String]
    /// selecting type of network call
    let method: HttpMethod
    /// body data for request
    let body: String?
    ///how to parse your precious data
    let parse: ((Data) -> Type?)?
    
    /**
     Initializes the resource with the given params for making a network call.
     
     - Parameters:
        url: address where this network call should be made
        queryParams: queries to add to the url address
        header: header dict for request
        method: selecting type of network call
        body: body data for request
    */
    init(url: URL,
         queryParams: [String: String] = [:],
         method: HttpMethod = .get,
         body: String? = nil,
         parse: ((Data) -> Type?)? = nil) {
        
        //setting all the properties for this struct
        self.url = url
        self.queryParams = queryParams
        self.method = method
        self.body = body
        self.parse = parse
        
    }
    
    /**
     Builds and returns a URLRequest based on the Resource properties
     
     - Returns: URLRequest object with the basic params populated from this Resource
    */
    func urlRequest(extraHeaders: [String: String] = [:]) -> URLRequest? {
        
        // buidling up the url
        //setting query params with components
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = queryParams.map { (entry) -> URLQueryItem in
            
            let (key, value) = entry
            return URLQueryItem(name: key, value: value)
        }
        //checking the full url after query params
        guard let fullUrl = components?.url else {
            return nil
        }
        
        //building up the urlRequest with url and header/body
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        
        //setting header fields
        let headers = extraHeaders
        for entry in headers {
            urlRequest.setValue(entry.value, forHTTPHeaderField: entry.key)
        }

        //setting body
        urlRequest.httpBody = body?.data(using: .utf8)
        
        return urlRequest
    }
    
} // Resource (to fold/unfold code: alt cmd (left/right) (isn't that cool?!)

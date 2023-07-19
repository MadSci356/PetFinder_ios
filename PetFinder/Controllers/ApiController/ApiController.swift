//
//  ApiController.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/5/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

enum FetchDataError: Error {
    case badURL
    case networkErr(Error?)
    case serverErr(String)
    case error(String)
    
    var errorText: String {
        switch self {
        case .badURL:
            return "Bad Url"

        case .networkErr(let error):
            return error?.localizedDescription ?? "Network Error while fetching data"
        
        case .serverErr(let message):
            return message
        case .error(let message):
            return message
        }
    }
}

class ApiController: MetaControllerConsumer {
    
    var metaController: MetaController?
    
    //object to manage calls
    let session = URLSession.shared
    
    ///header vals to be used when making network calls
    private var extraHeaders = [String: String]()

    /**
        Initializes the API controller
    */
    init(metaController: MetaController?) {
        self.metaController = metaController
    }
    
    func addAuthToken(authToken: AuthToken) {
        debugLog("Setting auth token to: \(authToken.token)")
        extraHeaders["Authorization"] = "Bearer \(authToken.token)"
    }
    
    /**
     Given a network Resource for a Type, this method will use a URLSessions data task to attempt
     retreival of the data.
     
      Try to fetch the data. Learning and copying from:
      [Learn App Making](https://learnappmaking.com/urlsession-swift-networking-how-to/)
 
      ### Basic process for this method:
      1. Check if this object has made a valid (non nil) url
      2. Start an (async) data task with URLSession
      3. Resume/end task
 
      ### Process for the async data task:
      -
      - Closure with data, response, and error vars
      - Check for networking error and that some data is returned
      - Check response to see if something went wrong during the comm
      - Decode data using JSONdecoder and Structs that use Codable
      - If data is decoded, give it to the completion handler. If not, return a failure result type
     
     - Parameters:
        - resource: A Resource object with the necessary information to make a URLRequest
                    and to parse the received data (if any)
        - completion: A Result closure that will indicate if data is properly received and decoded.
                    If result is a success, will include data of Type.
    */
     func load<Type>(resource: Resource<Type>,
                     completion: ((Result<Type, FetchDataError>) -> Void)? = nil) {
        
        guard let urlRequest = resource.urlRequest(extraHeaders: extraHeaders) else {
            assertionFailure("URLRequest nil from Resource")
            completion?(.failure(.error("URLRequest nil from Resource")))
            return
        }
        
        infoLog("Starting Data Task, \(Type.self)")
        let task = session.dataTask(with: urlRequest) {data, response, error in
            var result: Result<Type, FetchDataError> = .failure(
                FetchDataError.error("Initial Result value, not made call yet."))
                self.infoLog("Initial Result value for \(Type.self), not made call yet.")
            defer {
                DispatchQueue.main.async {
                    completion?(result)
                }
            }
            
            //checking for error and data (networking)
            guard error == nil, let data = data else {
                self.errorLog("Fetch Data Networking error. \(String(describing: error))")
                result = .failure(.networkErr(error))
                return
            }
            
            //checking http response
            guard let response = response as? HTTPURLResponse else {
                result = .failure(.serverErr("HTTPURLResponse error"))
                self.errorLog("HTTPURLResponse error")
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                self.errorLog("Load() Server error")
                result = .failure(.serverErr(String(response.statusCode)))
                return
            }
            
            //pet list validation
            guard let parse = resource.parse, let decoded = parse(data) else {
                self.errorLog("Unable to decode JSON Data")
                result = .failure(.error("Unable to decode JSON Data"))
                return
            }
            result = .success(decoded)
            self.debugLog("Successfully decoded \(Type.self)")
        }
        task.resume()
        
    }

} //class

//
//  PetFinder_Resource.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/8/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

extension PetFinder {
    
    /**
     Generates a Resource for making REST Call to PetFinder v2 API. The resulting url will look something like:
     https://api.petfinder.com/v2/animals?type=rabbit&location=Apex,NC
     
     - Parameters:
     - for: What type of animal to search on PetFinder. ex: "Rabbit"
     - at: Where to search for the pet? ex: Apex, NC
     - with: a valid token from PetFinder to use the API
     
     - Returns: Resource<PetFinder> that can be used to make REST calls
     */
    
    static func resource(for animal: String, at location: String) -> Resource<[Pet]> {
        
        //base url for getting pet data
        let baseUrl = URL(string: "https://api.petfinder.com/v2/animals")! //swiftlint:disable:this force_unwrapping
        
        // params to fill url request
        let paramDict = ["type": animal, "location": location]
        
        // including access token in request's header
        
        let parsedData = {
            (data: Data) -> [Pet]? in
            let decoder = JSONDecoder()
            let petList = try? decoder.decode(PetFinder.self, from: data).animals
            return petList
        }
        
        return Resource(url: baseUrl, queryParams: paramDict, parse: parsedData)
        
    }
    
}

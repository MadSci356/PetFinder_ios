//
//  PetFinderTypes_Resource.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/17/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

extension PetFinderTypes {
    
    /// This one is like meta data for pets
    static var resource: Resource<[AnimalType]> {
        
        //base url for PetFinder API v2
        let baseUrl = URL(string: "https://api.petfinder.com/v2/types")! //swiftlint:disable:this force_unwrapping
        
        // NOTE: no param dict for this endpoint so far
        
        let parsedData = {
            (data: Data) -> [AnimalType]? in
            let decoder = JSONDecoder()
            let typeList = try? decoder.decode(PetFinderTypes.self, from: data).types
            return typeList
        }
        
        return Resource(url: baseUrl, parse: parsedData)
    }
}

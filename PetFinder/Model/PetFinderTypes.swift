//
//  PetFinderTypes.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/17/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

/**
 Using this to decode animal types at the https://api.petfinder.com/v2/types endpoint.
 Basic Structure:
 DataReturned->types->[AnimalType]
                            | each animal type...
                             -> Name (ex: Dog)
                             -> coats: list of strings [short, long, medium,...]
                             -> colors: list of strings
                             -> list of genders: list of 0, 2, or the current year amount of strings, apparently.
 */
struct PetFinderTypes: Codable {
    
    var types: [AnimalType]?
}

struct AnimalType: Codable, Equatable {
    
    var name: String?
    var coats: [String]?
    var colors: [String]?
    var genders: [String]?
}

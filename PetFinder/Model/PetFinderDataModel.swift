//
//  PetFinderDataModel.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/4/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation
import RealmSwift
/**
 
 Struct for parsing JSON data from PetFinder API. Uses Codable struct
 General view of how the json is organized:
 
 DataRetured->animals->[list of pets]
                                    | each pet...
                                     -> age
                                     -> url
                                     -> name
                                     -> gender
                                     -> detail (description)
                                     -> photos -> [list of photos]
                                                        | each photo
                                                         ->small
                                                          ->medium
                                                          ->large
                                                          ->full
*/

struct PetFinder: Codable {
    var animals: [Pet]?
}

/**
    Conforming Pet to Equatable. Equality of Pet objects determined
    by their id number (idNum) property.
 */
struct Pet: Codable, Equatable {
    static func == (lhs: Pet, rhs: Pet) -> Bool {
        return lhs.idNum == rhs.idNum
    }
    
    var url: String?
    var age: String?
    var name: String?
    var gender: String?
    var type: String?
    var detail: String?
    var photos: [Photo]?
    var idNum: Int?
    var contact: Contact

    enum CodingKeys: String, CodingKey {
        case url
        case age
        case name
        case gender
        case type
        case detail = "description"
        case contact
        case photos
        case idNum = "id"
    }
}

struct Contact: Codable, Equatable {
    var phone: String?
}

struct Photo: Codable, Equatable {
    var small: String?
    var full: String?
    
    var smallImageUrl: URL? {
        return  URL(string: small ?? "")
    }
    
    var fullImageUrl: URL? {
        return URL(string: full ?? "")
    }
}

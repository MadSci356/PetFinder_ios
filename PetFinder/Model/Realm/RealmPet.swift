//
//  RealmPet.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/11/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation
import RealmSwift

/// if it's convention to have one class/file then should lint complain about file name and class name?
class RealmPet: Object {
    
    //properties that a VC might use
    // apparently @objc is needed to make it work
    @objc dynamic var url: String?
    @objc dynamic var age: String?
    @objc dynamic var name: String?
    @objc dynamic var gender: String?
    @objc dynamic var type: String?
    @objc dynamic var detail: String?
    @objc dynamic var smallPhoto: String?
    @objc dynamic var fullPhoto: String?
    @objc dynamic var idNum = -1
    @objc dynamic var phone: String?

    convenience init(withPet pet: Pet) {
        self.init()
        self.url = pet.url
        self.age = pet.age
        self.name = pet.name
        self.gender = pet.gender
        self.type = pet.type
        self.detail = pet.detail
        self.smallPhoto = pet.photos?.first?.small
        self.fullPhoto = pet.photos?.first?.full
        self.phone = pet.contact.phone
        self.idNum = pet.idNum ?? -1
        
    }
    
    /// Unique identifier for this object
    override static func primaryKey() -> String? {
        return "idNum"
    }
    
}

//Object has Equatable protocol
extension RealmPet {
    static func == (lhs: RealmPet, rhs: RealmPet) -> Bool {
        return lhs.idNum == rhs.idNum
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? RealmPet else {
            return false
        }
        return other == self
    }
}

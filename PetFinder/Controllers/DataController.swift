//
//  DataController.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/11/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation
import RealmSwift

/// default and the most basic Realm config that allows the use of Realm library in the app
private let defaultConfig = Realm.Configuration(inMemoryIdentifier: "RealmInMemoryID")

/**
 This class will contain functions to manage acquiring and converting data into Realm types and files
 
 */
class DataController: MetaControllerConsumer {
    
    var metaController: MetaController?
    
    let config: Realm.Configuration
    let mainThreadRealm: Realm
    
    init?(metaController: MetaController?, realmConfig: Realm.Configuration = defaultConfig) {
        
        self.metaController = metaController
        config = realmConfig
        Realm.Configuration.defaultConfiguration = realmConfig
        
        //creating a happy little realm object
        if let realm = try? Realm(configuration: realmConfig) {
            mainThreadRealm = realm
        } else {
            assertionFailure("Failed to create mainThreadRealm")
            return nil
        }
    }
    
    /// Calls PetFinder API for pet data based on hard-coded search params.
    /// Converts the decoded Pet list struct from mApli.load() into Realm pet Objects
    /// and loads them into Realm database
    func petSearch() -> Results<RealmPet> {
        
        //call mApi's load
        self.infoLog("Calling petSearch to load data into realm")
        self.verboseLog("Search: Rabbits in Apex, NC")
        
        let petResource = PetFinder.resource(for: "Rabbit", at: "Apex, NC")
        mApi?.load(resource: petResource) { result in
            
            switch result {
            case .success(let pets):
                //convert and add pet data to realm
                self.convertPetsToRealm(pets: pets)
            case .failure(let error):
                self.errorLog("Did not receive valid pet data, \(error.errorText)")
            }
        }
        
        //does this need to be returned with main async ?
        return mainThreadRealm.objects(RealmPet.self)
    }
    
    /// Converts a given list of Pet to RealmPet objects
    /// Add the RealmPets to mainThreadRealm.
    /// I wish the alt + cmd + fwd slash put /** */ comment markers. Gots to look into it.
    ///
    /// - Parameter pets: list of Pet struct objects
    func convertPetsToRealm(pets: [Pet]) {
        
        // f(x) = RealmPet(withPet: x)
        let realmPets = pets.map {
            //RealmPet(withPet: $0)
            getValueDict(forPet: $0)
        }
        
        //attempting to write to realm data file
        do {
            try mainThreadRealm.write {
                realmPets.forEach {
                    mainThreadRealm.create(RealmPet.self, value: $0, update: .modified)
                }
            }
        } catch {
            self.errorLog("Could not write converted RealmPet list to Realm instance, \(error)")
        }

    }
    
    /// Gets the value dict for the Pet object
    /// To use with Realm.create()??
    ///
    /// - Parameter pet: Pet object
    /// - Returns: [RealmPetVars: Value]
    private func getValueDict(forPet pet: Pet) -> [String: Any?] {
        //var dict = [String: Any]()

        var dict = [String: Any?]()
        dict["url"] = pet.url
        dict["age"] = pet.age
        dict["name"] = pet.name
        dict["gender"] = pet.gender
        dict["type"] = pet.type
        dict["detail"] = pet.detail
        dict["smallPhoto"] = pet.photos?.first?.small
        dict["fullPhoto"] = pet.photos?.first?.full
        dict["idNum"] = pet.idNum
        dict["phone"] = pet.contact.phone
        return dict
    }
}

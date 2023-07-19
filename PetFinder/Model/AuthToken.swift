//
//  AuthToken.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/19/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

/**
 Structure for decoding data received when getting an Authorization token
 */
struct AuthToken: Codable, Equatable {
    var tokenType: String?
    var expiresIn: Int?
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case token = "access_token"
    }
}

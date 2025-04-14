//
//  Claim.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import Foundation

struct Claim: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Claims = [Claim]

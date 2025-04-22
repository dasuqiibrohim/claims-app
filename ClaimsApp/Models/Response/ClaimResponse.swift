//
//  ClaimResponse.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 21/04/25.
//

struct ClaimResponse: Codable, Identifiable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

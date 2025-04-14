//
//  ClaimService.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import Foundation
import Combine

protocol ClaimServiceProtocol { func fetchClaims() -> AnyPublisher<[Claim], Error> }

final class ClaimService: ClaimServiceProtocol {
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    func fetchClaims() -> AnyPublisher<[Claim], Error> {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Claims.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

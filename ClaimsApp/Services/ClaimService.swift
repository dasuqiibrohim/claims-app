//
//  ClaimService.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import Foundation
import Combine

protocol ClaimServiceProtocol {
    func fetchClaims() -> AnyPublisher<[ClaimResponse], Error>
    func fetchUsers() -> AnyPublisher<[User], Error>
}

final class ClaimService: ClaimServiceProtocol {
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    private let baseURLUser = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    func fetchClaims() -> AnyPublisher<[ClaimResponse], Error> {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode else {
                    throw ClaimServiceError.invalidResponse
                }
                return result.data
            }
            .decode(type: [ClaimResponse].self, decoder: JSONDecoder())
            .mapError { error -> Error in
                if error is DecodingError {
                    return ClaimServiceError.decodingError
                } else if let serviceError = error as? ClaimServiceError {
                    return serviceError
                } else {
                    return ClaimServiceError.serverError(error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    func fetchUsers() -> AnyPublisher<[User], Error> {
        var request = URLRequest(url: baseURLUser)
        request.httpMethod = "GET"

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode else {
                    throw ClaimServiceError.invalidResponse
                }
                return result.data
            }
            .decode(type: Users.self, decoder: JSONDecoder())
            .mapError { error -> Error in
                if error is DecodingError {
                    return ClaimServiceError.decodingError
                } else if let serviceError = error as? ClaimServiceError {
                    return serviceError
                } else {
                    return ClaimServiceError.serverError(error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

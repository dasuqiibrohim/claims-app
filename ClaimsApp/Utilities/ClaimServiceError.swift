//
//  ClaimServiceError.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import Foundation

enum ClaimServiceError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
    case custom(Error)
    
    init(error: Error) {
        if let apiError = error as? ClaimServiceError {
            self = apiError
        } else {
            self = .custom(error)
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .invalidResponse: return "Invalid server response."
        case .decodingError: return "Failed to read data from server."
        case .serverError(let message): return message
        case .custom(let err): return err.localizedDescription
        }
    }
}

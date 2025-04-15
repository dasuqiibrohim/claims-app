//
//  MockClaimService.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import Foundation
import Combine
@testable import ClaimsApp

enum MockError: Error, LocalizedError {
    case mockFailure
    var errorDescription: String? {
        return "An unexpected error occurred."
    }
}

class MockClaimService: ClaimServiceProtocol {
    var result: Result<[Claim], Error>
    init(result: Result<[Claim], Error>) {
        self.result = result
    }
    
    func fetchClaims() -> AnyPublisher<[Claim], Error> {
        switch result {
        case .success(let claims):
            return Just(claims)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}

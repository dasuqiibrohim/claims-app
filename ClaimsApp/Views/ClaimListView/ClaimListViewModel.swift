//
//  ClaimListViewModel.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import Foundation
import Combine

@MainActor class ClaimListViewModel: ObservableObject {
    @Published var claims: [Claim] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    
    private let claimService: ClaimServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: ClaimServiceProtocol = ClaimService()) {
        self.claimService = service
    }

//    var filteredClaims: [Claim] {
//        if searchText.isEmpty {
//            return claims
//        } else {
//            return claims.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.description.localizedCaseInsensitiveContains(searchText) }
//        }
//    }
//
    func fetchClaims() {
        claimService.fetchClaims()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        if let claimError = error as? ClaimServiceError {
                            self.errorMessage = claimError.errorDescription
                        } else {
                            self.errorMessage = error.localizedDescription
                        }
                    case .finished: break
                    }
                },
                receiveValue: { claims in
                    self.claims = claims
                }
            ) .store(in: &cancellables)
    }
}

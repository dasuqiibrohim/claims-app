//
//  ClaimListViewModel.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import Foundation
import Combine

@MainActor class ClaimListViewModel: ObservableObject {
    @Published var allClaims: [Claim] = []
    @Published var filteredClaims: [Claim] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    
    private let claimService: ClaimServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    var searchCancellabel: AnyCancellable?

    init(service: ClaimServiceProtocol = ClaimService()) {
        self.claimService = service
        fetchClaims()
        setupSearch()
    }

    private func fetchClaims() {
        isLoading = true
        errorMessage = nil
        
        claimService.fetchClaims()
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    if let claimError = error as? ClaimServiceError {
                        self?.errorMessage = claimError.errorDescription
                    } else {
                        self?.errorMessage = error.localizedDescription
                    }
                case .finished: break
                }
            } receiveValue: { [weak self] claims in
                self?.allClaims = claims
                self?.filteredClaims = claims
            }
            .store(in: &cancellables)
    }
    private func setupSearch() {
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .combineLatest($allClaims)
            .map { (query, claims) in
                guard !query.isEmpty else { return claims }
                return claims.filter { $0.title.localizedCaseInsensitiveContains(query) || $0.body.localizedCaseInsensitiveContains(query) }
            }
            .assign(to: &$filteredClaims)
    }
}

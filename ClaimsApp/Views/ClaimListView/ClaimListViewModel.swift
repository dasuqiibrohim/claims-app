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
    @Published var allUsers: [User] = []
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
    
    func fetchClaims() {
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
                let claimsData = claims.map {
                    Claim(userID: $0.userID, id: $0.id, title: $0.title, body: $0.body, name: "")
                }
                self?.allClaims = claimsData
                self?.filteredClaims = claimsData
                self?.fetchUsers()
            }
            .store(in: &cancellables)
    }
    func fetchUsers() {
        claimService.fetchUsers()
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
            } receiveValue: { [weak self] users in
                self?.allUsers = users
                self?.getUserName()
            }
            .store(in: &cancellables)
    }
    func setupSearch() {
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
    func getUserName() {
        filteredClaims = allClaims.map { claim in
            let selectedUser = allUsers.first { user in
                user.id == claim.userID
            }
            return Claim(
                userID: claim.userID,
                id: claim.id,
                title: claim.title,
                body: claim.body,
                name: selectedUser?.name ?? "-"
            )
        }
    }
}

//
//  ClaimListViewModelTests.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import XCTest
import Combine
@testable import ClaimsApp

final class ClaimsListViewModelTests: XCTestCase {
    var viewModel: ClaimListViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    @MainActor func testFilteringSearchText() {
        let mockClaims = [
            Claim(userID: 1, id: 1, title: "Apple", body: "Something"),
            Claim(userID: 2, id: 2, title: "Banana", body: "Another")
        ]
        let service = MockClaimService(result: .success(mockClaims))
        viewModel = ClaimListViewModel(service: service)
        let expectation = XCTestExpectation(description: "Search filtering works")
        
        viewModel.fetchClaims()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewModel.searchText = "apple"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                XCTAssertEqual(self.viewModel.filteredClaims.count, 1)
                XCTAssertEqual(self.viewModel.filteredClaims.first?.title, "Apple")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    @MainActor func testFetchErrorHandling() {
        let service = MockClaimService(result: .failure(MockError.mockFailure))
        viewModel = ClaimListViewModel(service: service)
        let expectation = XCTestExpectation(description: "Handles fetch error")
        let cancellable = viewModel.$errorMessage
            .dropFirst()
            .sink { message in
                if let errorMessage = message {
                    XCTAssertEqual(errorMessage, "An unexpected error occurred.")
                    expectation.fulfill()
                }
            }

        viewModel.fetchClaims()

        wait(for: [expectation], timeout: 2.0)
        cancellable.cancel()
    }
}

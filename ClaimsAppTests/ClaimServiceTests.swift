//
//  ClaimServiceTests.swift
//  ClaimsApp
//
//  Created by Mufallah FD on 15/04/25.
//

import XCTest
import Combine
@testable import ClaimsApp

final class ClaimServiceTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func testFetchClaimsSuccess() {
        let mockClaims = [
            Claim(userID: 1, id: 1, title: "Test Title", body: "Test Body")
        ]
        let service = MockClaimService(result: .success(mockClaims))
        let expectation = XCTestExpectation(description: "Fetch claims success")
        
        service.fetchClaims()
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Expected success, got failure")
                }
            } receiveValue: { claims in
                XCTAssertEqual(claims.count, 1)
                XCTAssertEqual(claims.first?.title, "Test Title")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchClaimsFailure() {
        let service = MockClaimService(result: .failure(MockError.mockFailure))
        let expectation = XCTestExpectation(description: "Fetch claims failure")
        
        service.fetchClaims()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            } receiveValue: { _ in
                XCTFail("Expected failure, got success")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testLiveClaimAPI() {
        let service = ClaimService()
        let expectation = XCTestExpectation(description: "Live fetch")
        
        service.fetchClaims()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            } receiveValue: { claims in
                XCTAssertGreaterThan(claims.count, 0, "Claims harus tidak kosong")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}

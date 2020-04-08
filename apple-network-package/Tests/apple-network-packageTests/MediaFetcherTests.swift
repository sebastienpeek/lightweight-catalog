//
//  MediaFetcherTests.swift
//  
//
//  Created by Sebastien Audeon on 4/8/20.
//

import XCTest
@testable import apple_network_package

final class MediaFetcherTests: XCTestCase {
    
    private let defaultExpectationHandler: XCWaitCompletionHandler = { (error) in
        if error != nil {
            XCTFail("Expectations Timeout")
        }
    }
    
    func testSearchQuery() {
        
        let searchExpectation = expectation(description: "Waiting for search response")
        
        MediaFetcher().search(with: "testing with the tests") { (result) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                XCTFail("Received error message")
            case .none:
                XCTFail("Should never reecive none")
            }
            searchExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: defaultExpectationHandler)
        
    }

    static var allTests = [
        ("testSearchQuery", testSearchQuery),
    ]
}

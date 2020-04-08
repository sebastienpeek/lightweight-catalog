//
//  MediaManagerTests.swift
//  
//
//  Created by Sebastien Audeon on 4/8/20.
//

import XCTest

@testable import apple_data_package

class MockedManager: MediaManagerProtocol {
    
    var mockedMedia: [Media] = [
        
    ]
    
    func search(with term: String?, completion: @escaping MediaCompletion) {
        
    }
    
}

final class MediaManagerTests: XCTestCase {
    
    private let defaultExpectationHandler: XCWaitCompletionHandler = { (error) in
        if error != nil {
            XCTFail("Expectations Timeout")
        }
    }
    
    func testMockedSearchFunctionality() {
        
        MockedManager().search(with: "test") { (collection, error) in
            if let collection = collection {
                print(collection)
            }
        }
        
    }
    
    func testSearchFunctionality() {
        
        let searchExpectation = expectation(description: "Waiting for search response")
        
        MediaManager().search(with: "test") { (collection, error) in
            
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            
            if collection != nil {
                searchExpectation.fulfill()
            }
            
        }
        
        waitForExpectations(timeout: 5, handler: defaultExpectationHandler)
        
    }

    static var allTests = [
        ("testMockedSearchFunctionality", testMockedSearchFunctionality),
    ]
}

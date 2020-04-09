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
        Media(with: 1),
        Media(with: 2, genre: .song),
        Media(with: 3, genre: .song),
        Media(with: 4, genre: .song),
        Media(with: 5, genre: .artist),
        Media(with: 6, genre: .album)
    ]
    
    func favorites() -> [MediaType : [Media]]? {
        return sort(with: mockedMedia)
    }
    
    func favorite(_ media: Media) {
        
    }
    
    func unfavorite(_ media: Media) {
        
    }
    
    func search(with term: String?, completion: @escaping MediaCompletion) {
        completion(sort(with: mockedMedia), nil)
    }
    
    private func sort(with media: [Media]) -> [MediaType: [Media]]? {
        return Dictionary(grouping: media ) { $0.genre ?? .none }
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
        
        MediaManager().search(with: "Fever 333") { (collection, error) in
            
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

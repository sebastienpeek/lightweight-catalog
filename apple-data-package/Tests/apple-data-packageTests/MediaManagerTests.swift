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
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testSearchFunctionality() {
        
        MockedManager().search(with: "test") { (collection, error) in
            if let collection = collection {
                print(collection)
            }
        }
        
    }

    static var allTests = [
        ("testSearchFunctionality", testSearchFunctionality),
    ]
}

//
//  MediaFetcher.swift
//  
//
//  Created by Sebastien Audeon on 4/8/20.
//

import Foundation

protocol MediaFetcherProtocol {
    var baseUrl: String { get }
}

public typealias NetworkCompletionHandler = (Result<Any, Error>?) -> Void

public class MediaFetcher: MediaFetcherProtocol {
    
    var baseUrl: String {
        return "https://itunes.apple.com"
    }
    
    public func search(with term: String?, completion: @escaping NetworkCompletionHandler) {
        
        
        
    }
    
}

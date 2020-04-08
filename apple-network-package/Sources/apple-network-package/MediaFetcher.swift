//
//  MediaFetcher.swift
//  
//
//  Created by Sebastien Audeon on 4/8/20.
//

import Foundation

protocol MediaFetcherProtocol {
    static var baseUrl: String { get }
}

public typealias NetworkCompletionHandler = (Result<Any, Error>?) -> Void

public class MediaFetcher: MediaFetcherProtocol {
    
    static var baseUrl: String {
        return "https://itunes.apple.com"
    }
    
    public init() { } // Required to be able to get instance outside of package.
    
    public func search(with term: String?, completion: @escaping NetworkCompletionHandler) {
        
        guard let search = term else { return }
        
        let session = URLSession.shared
        
        let request: URLRequest!
        do {
            request = try MediaRouter.search(search).asURLRequest()
        } catch (let error) {
            print(error)
            return
        }
        
        // Build up the completion handler.
        let completionHandler: (Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            
            print(response)
            
            if let error = error {
                // We want to return a failure to completion handler.
                completion(.failure(error))
                return
            }
            
            
            // If we have made it this far, let's pass the response data back to the data layer to parse.
            if let data = data {
                completion(.success(data))
            }
            
        }
        
        let task = session.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
        
    }
    
}

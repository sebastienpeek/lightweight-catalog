//
//  MediaRouter.swift
//  
//
//  Created by Sebastien Audeon on 4/8/20.
//

import Foundation

enum MediaRouter {
    
    case search(String)
    
    func asURLRequest() throws -> URLRequest {
        
        // We want to get the base URL as URL components.
        var baseURL = try MediaFetcher.baseUrl.asURL()
        
        switch self {
        case .search(let term):
            // We now want to make sure that we have set the query items as expected.
            baseURL.queryItems = [
                URLQueryItem(name: "search", value: term)
            ]
        }
        
        guard let url = baseURL.url else { fatalError("The url has been built up incorrectly.") }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.timeoutInterval = 30
        
        return urlRequest
        
    }
    
}

extension String {
    
    func asURL() throws -> URLComponents {
        guard let url = URLComponents(string: self) else {
            fatalError("URL could not be used.")
        }
        return url
    }
    
}

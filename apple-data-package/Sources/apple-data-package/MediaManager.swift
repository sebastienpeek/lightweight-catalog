//
//  MediaManager.swift
//  
//
//  Created by Sebastien Audeon on 4/8/20.
//

import Foundation

import apple_network_package

public typealias MediaCompletion = ([MediaType: [Media]]?, Error?) -> Void

protocol MediaManagerProtocol {
    func search(with term: String?, completion: @escaping MediaCompletion)
}

public class MediaManager: MediaManagerProtocol {
    
    public init() { }
    
    public func search(with term: String?, completion: @escaping MediaCompletion) {
        // Here we handle the network request once it has been built out.
        
        if let term = term {
            
            MediaFetcher().search(with: term) { (result) in
                switch result {
                case .success(let data):
                    guard let data = data as? Data else { return }
                    
                    // Now that we have the data, we want to decode this into the objects.
                    do {
                        guard let media = try self.decode(with: data) else { return }
                        let sorted = self.sort(with: media)
                        completion(sorted, nil)
                    } catch {
                        completion(nil, error)
                    }
                    
                case .failure(let error):
                    completion(nil, error)
                default:
                    print("What?")
                }
            }
            
        } else {
            
        }
        
    }
    
}

// MARK: Private Functions
extension MediaManager {
    
    func sort(with media: [Media]) -> [MediaType: [Media]]? {
        
        
        return nil
    }
    
    func decode(with data: Data) throws -> [Media]? {
        
        // Serialize the data into an object
        do {
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            print(decodedResponse)
            return decodedResponse.results
        } catch {
            print("Error during JSON serialization: \(error.localizedDescription)")
            throw error
        }
        
    }
    
}

//
//  MediaManager.swift
//  
//
//  Created by Sebastien Audeon on 4/8/20.
//

import Foundation

public typealias MediaCompletion = ([MediaType: [Media]]?, Error?) -> Void

protocol MediaManagerProtocol {
    func search(with term: String?, completion: @escaping MediaCompletion)
}

public class MediaManager: MediaManagerProtocol {
    
    func search(with term: String? = nil, completion: @escaping MediaCompletion) {
        // Here we handle the network request once it has been built out.
        
    }
    
}

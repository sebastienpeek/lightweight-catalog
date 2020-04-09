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
    func favorites() -> [MediaType: [Media]]?
    func search(with term: String?, completion: @escaping MediaCompletion)
    func favorite(_ media: Media)
    func unfavorite(_ media: Media)
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
    
    public func favorites() -> [MediaType : [Media]]? {
        guard let favorites = self.getFavorites() else { return nil }
        // We need to mark them all as favorites.
        for item in favorites {
            item.favorited = true
        }
        return sort(with: favorites)
    }
    
    public func favorite(_ media: Media) {
        self.insert(favorite: media)
    }
    
    public func unfavorite(_ media: Media) {
        self.remove(favorite: media)
    }
    
}

// MARK: - Private Functions

// MARK: Handling Local Persistance
extension MediaManager {
    
    private func insert(favorite: Media) {
        
        let url = getDocumentsDirectory().appendingPathComponent("favorites")
        
        var favoritesToSave: [Media] = []
        
        // We need to get the favorites first.
        if let favorites = self.getFavorites() {
            favoritesToSave.append(contentsOf: favorites)
        }
        
        // Append the new favorite, encode and save.
        favoritesToSave.append(favorite)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(favoritesToSave)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
        
    }
    
    private func remove(favorite: Media) {
        
        let url = getDocumentsDirectory().appendingPathComponent("favorites")
        
        var favoritesToSave: [Media] = []
        
        // We need to get the favorites first.
        if let favorites = self.getFavorites() {
            favoritesToSave.append(contentsOf: favorites)
        }
        
        // Remove the favorite.
        for (key, value) in favoritesToSave.enumerated() where value.id == favorite.id {
            favoritesToSave.remove(at: key)
        }
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(favoritesToSave)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
        
    }
    
    private func getFavorites() -> [Media]? {
        
        let url = getDocumentsDirectory().appendingPathComponent("favorites")
        
        if !FileManager.default.fileExists(atPath: url.path) {
            print("There isn't an item here yet.")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode([Media].self, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            print("There's no favorites yet!")
        }
        
        return nil
        
    }
    
    fileprivate func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}

// MARK: Handling Networking Response
extension MediaManager {
    
    private func sort(with media: [Media]) -> [MediaType: [Media]]? {
        return Dictionary(grouping: media ) { $0.genre ?? .none }
    }
    
    private func decode(with data: Data) throws -> [Media]? {
        
        // Serialize the data into an object
        do {
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            return decodedResponse.results
        } catch {
            print("Error during JSON serialization: \(error.localizedDescription)")
            throw error
        }
        
    }
    
}

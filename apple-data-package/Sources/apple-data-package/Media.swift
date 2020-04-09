//
//  Media.swift
//  
//
//  Created by Sebastien Audeon on 4/8/20.
//

import Foundation

public enum MediaType: String, Codable {
    case book
    case album
    case coachedAudio = "coached-audio"
    case featureMovie = "feature-movie"
    case interactiveBooklet = "interactive-booklet"
    case musicVideo = "music-video"
    case pdf
    case podcast
    case podcastEpisode = "podcast-episode"
    case softwarePackage = "software-package"
    case song
    case tvEpisode = "tv-episode"
    case artist
    case none
}

class Response: Codable {
    
    var resultCount: Int?
    var results: [Media]?
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
    
}

public class Media: Codable {
    
    public var id: Int?
    
    public var name: String?
    public var artwork: String?
    public var genre: MediaType?
    public var url: String?
    
    public var favorited: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "artistId"
        case name = "artistName"
        case artwork = "artworkUrl60"
        case genre = "kind"
        case url = "collectionViewUrl"
    }
    
}

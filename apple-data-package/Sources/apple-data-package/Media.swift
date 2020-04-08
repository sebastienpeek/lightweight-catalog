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
}


public class Media: Codable {
    
    public var id: Int?
    
    public var name: String?
    public var artwork: String?
    public var genre: MediaType?
    public var url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artwork
        case genre
        case url
    }
    
}

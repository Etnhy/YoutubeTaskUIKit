//
//  Configuration.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import Foundation

struct Configuration {
    struct Net {
        // api url youtube
        static let api_url: String = {
            guard let api = Bundle.main.object(forInfoDictionaryKey: "api_youtube") as? String else {
                fatalError()
            }
            return "\(api)"
        }()
        // api key 
        static let apiKey: String = {
            guard let key = Bundle.main.object(forInfoDictionaryKey: "api_key") as? String else {
                fatalError()
            }
            return "\(key)"
        }()
        
    }
    
    struct Playlists {
        static let first    : String = "PLNZta_SFvNjFecxGDwyektG2-3LdgnhbD"
        static let second   : String = "PLNZta_SFvNjHIXf0uM13UjnLcZov8WWOb"
    }
}

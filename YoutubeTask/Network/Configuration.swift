//
//  Configuration.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import Foundation

struct Configuration {
    
    // MARK: - Net - api url + api key
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
    
    // MARK: -  Playlists id
    struct Playlists {
        static let first    : String = "PLNZta_SFvNjFecxGDwyektG2-3LdgnhbD"
        static let second   : String = "PLNZta_SFvNjHIXf0uM13UjnLcZov8WWOb"
    }
    
    // MARK: - Channels id
    struct Channels {
        static let firstChannel     = "UCpOrC2F6a6SswsBxGT0bJaA"
        static let secondChannel    = "UCf-M7ZMAeru8ubUHWQsxiVQ"
        static let thirdChannel     = "UCnQHLFKsCRzyYTLJgA3Ud8Q"
        static let fourthChannel    = "UCIgA09xiZmp-xxrcf_tFEVw"
    }
}

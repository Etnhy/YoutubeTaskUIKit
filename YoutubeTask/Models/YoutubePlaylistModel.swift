//
//  YoutubeModel.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import Foundation

    // MARK: - Welcome
struct Welcome: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String?
    let items: [Items]
}

    // MARK: - Items
struct Items: Codable {
    let kind: String
    let etag: String
    let id:   String
    let snippet: Snippet
}

    // MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let playlistId: String
    let position: Int
    let resourceId: ResourceId
    let videoOwnerChannelTitle: String
    let videoOwnerChannelId: String

}

    // MARK: - ContentDetails
struct ContentDetails: Codable {
    let videoId: String
    let videoPublishedAt: String
}

    // MARK: -  Thumbnails + Medium
struct Thumbnails: Codable {
    let medium: Medium
    
}
struct Medium: Codable {
    let url: String
    let width: Int
    let height: Int
}

    // MARK: - ResourceId
struct ResourceId: Codable {
    let kind: String
    let videoId: String
}

    // MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}

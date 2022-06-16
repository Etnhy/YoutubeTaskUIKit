//
//  YoutubeChannelsModel.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 16.06.2022.
//

import Foundation

struct YoutubeChannelsModel: Codable {
    var kind: String
    var etag: String
    var pageInfo: ChannelsPageInfo
    var items: [YoutubeChannelItems]
}

struct ChannelsPageInfo: Codable {
    var totalResults:   Int
    var resultsPerPage: Int
}

struct YoutubeChannelItems: Codable {
    var kind:   String
    var etag:   String
    var id:     String
    var snippet: YouTubeChannelSnippet
    var contentDetails: YouTubeChannelContentDetails
    var statistics: YouTubeChannelStatistics
    
}

struct YouTubeChannelSnippet: Codable {
    var title: String
    var description: String
    var publishedAt: String
    var thumbnails: YouTubeChannelThumbnails
    var localized: YouTubeChannelLocalized

}

struct YouTubeChannelContentDetails: Codable {
    var relatedPlaylists: YoutubeChannelRelatedPlaylists
}

struct YoutubeChannelRelatedPlaylists: Codable {
    var likes: String
    var uploads: String
}

struct YouTubeChannelStatistics: Codable {
    var viewCount: String
    var subscriberCount: String
    var hiddenSubscriberCount: Bool
    var videoCount: String
}

struct YouTubeChannelThumbnails: Codable {
    var high: HighPicture
}
struct HighPicture: Codable {
    var url: String
}

struct YouTubeChannelLocalized: Codable {
    var title: String
    var description: String
}

//
//  YoutubeChannelsModel.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 16.06.2022.
//

import Foundation

// MARK: - YoutubeChannelsModel
struct YoutubeChannelsModel: Codable {
    var kind: String
    var etag: String
    var pageInfo: ChannelsPageInfo
    var items: [YoutubeChannelItems]
}
// MARK: - ChannelsPageInfo
struct ChannelsPageInfo: Codable {
    var totalResults:   Int
    var resultsPerPage: Int
}
// MARK: - YoutubeChannelItems
struct YoutubeChannelItems: Codable {
    var kind:   String
    var etag:   String
    var id:     String
    var snippet: YouTubeChannelSnippet
    var contentDetails: YouTubeChannelContentDetails
    var statistics: YouTubeChannelStatistics
    
}
// MARK: - YouTubeChannelSnippet
struct YouTubeChannelSnippet: Codable {
    var title: String
    var description: String
    var publishedAt: String
    var thumbnails: YouTubeChannelThumbnails
    var localized: YouTubeChannelLocalized

}

// MARK: - YouTubeChannelContentDetails
struct YouTubeChannelContentDetails: Codable {
    var relatedPlaylists: YoutubeChannelRelatedPlaylists
}

// MARK: - YoutubeChannelRelatedPlaylists
struct YoutubeChannelRelatedPlaylists: Codable {
    var likes: String
    var uploads: String
}

// MARK: - YouTubeChannelStatistics
struct YouTubeChannelStatistics: Codable {
    var viewCount: String
    var subscriberCount: String
    var hiddenSubscriberCount: Bool
    var videoCount: String
}

// MARK: - YouTubeChannelThumbnails + HighPicture
struct YouTubeChannelThumbnails: Codable {
    var high: HighPicture
}

struct HighPicture: Codable {
    var url: String
}

// MARK: - YouTubeChannelLocalized
struct YouTubeChannelLocalized: Codable {
    var title: String
    var description: String
}

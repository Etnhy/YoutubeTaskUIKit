//
//  YoutubeVideoModel.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 16.06.2022.
//

import Foundation


// MARK: - YoutubeVideoResponse
struct YoutubeVideoResponse: Codable {
    var kind:   String
    var etag:   String
    var items:  [VideoItems]
    var pageInfo: VideoPageInfo
}

// MARK: - VideoItems
struct VideoItems: Codable {
    var kind:   String
    var etag:   String
    var id:     String
    var statistics: Statistics
}

// MARK: - Statistics
struct Statistics: Codable {
    var viewCount:      String
    var likeCount:      String
    var favoriteCount:  String
    var commentCount:   String
}

// MARK: - VideoPageInfo
struct VideoPageInfo: Codable {
    var totalResults:    Int
    var resultsPerPage: Int
}

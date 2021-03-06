//
//  NetworkContract.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 18.06.2022.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

// MARK: - NetworkLayerProtocol
protocol NetworkLayerProtocol {
//    func getYoutubePlaylist(playlistNumber: String,completion: @escaping (Result<Welcome, AFError>) -> ())
    
//    func getViewsVideos(videoId: String,completion: @escaping (Result<YoutubeVideoResponse,AFError>) ->())
    
//    func getChannels(completion: @escaping (Result<YoutubeChannelsModel,AFError>) -> ())
    
//    func getPlaylistPromHeader(playlistId: String,completion: @escaping (Result<Welcome,AFError>) -> ())
//
//    func getViewsToPlayer(videoId: String,completion: @escaping (Result<YoutubeVideoResponse,AFError>) ->())
    
    
    
    // MARK: -  rx
    func getChannels() -> Observable<YoutubeChannelsModel>

    func getYoutubePlaylist2(playlistNumber: String) -> Observable<Welcome>
    func getViewsVideos2(videoId: String) -> Observable<YoutubeVideoResponse>

    
    func getPlaylistPromHeader2(playlistId: String) -> Observable<Welcome>
    func getViewsToPlayer2(videoId: String) -> Observable<YoutubeVideoResponse>

    
}

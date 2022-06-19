//
//  NetworkManager.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import UIKit
import Alamofire

class NetworkManager: NetworkLayerProtocol {


    
    static let shared = NetworkManager()
    
    fileprivate let apiUrl = Configuration.Net.api_url
    fileprivate let apiKey = Configuration.Net.apiKey
    
    fileprivate let firstPlayList   = Configuration.Playlists.first
    fileprivate let secondPlaylist  = Configuration.Playlists.second
    
    fileprivate let firstChannel    = Configuration.Channels.firstChannel
    fileprivate let secondChannel   = Configuration.Channels.secondChannel
    fileprivate let thirdChannel    = Configuration.Channels.thirdChannel
    fileprivate let fourthChannel   = Configuration.Channels.fourthChannel
    
    // MARK: - Get views to player
    func getViewsToPlayer(videoId: String, completion: @escaping (Result<YoutubeVideoResponse, AFError>) -> ()) {
        let url = "\(apiUrl)videos?part=statistics&id=\(videoId)&key=\(apiKey)"
        downloadJson(url: url, completion: completion)
    }
    
    // MARK: - get playlist from header
    func getPlaylistPromHeader(playlistId: String, completion: @escaping (Result<Welcome, AFError>) -> ()) {
        let url = "\(apiUrl)playlistItems?playlistId=\(playlistId)&maxResults=10&part=snippet%2CcontentDetails&key=\(apiKey)"
        downloadJson(url: url, completion: completion)

    }
    
    // MARK: - Get channels
    func getChannels(completion: @escaping (Result<YoutubeChannelsModel, AFError>) -> ()) {
        let url = "\(apiUrl)channels?part=snippet%2CcontentDetails%2Cstatistics&id=\(firstChannel)&id=\(secondChannel)&id=\(thirdChannel)&id=\(fourthChannel)&key=\(apiKey)"
        downloadJson(url: url, completion: completion)
    }

    
    // MARK: - Get Youtube playlists (first + second)
    func getYoutubePlaylist(playlistNumber: String ,completion: @escaping (Result<Welcome, AFError>) -> ()) {
        let url = "\(apiUrl)playlistItems?playlistId=\(playlistNumber)&maxResults=10&part=snippet%2CcontentDetails&key=\(apiKey)"
        downloadJson(url: url, completion: completion)
    }
    
    // MARK: - get video views
    func getViewsVideos(videoId: String,completion: @escaping (Result<YoutubeVideoResponse,AFError>) ->()) {
        let url = "\(apiUrl)videos?part=statistics&id=\(videoId)&key=\(apiKey)"
        downloadJson(url: url, completion: completion)
    }
    
    // MARK: - generic feth func
    fileprivate func downloadJson<T:Decodable>(url: String, completion:@escaping(Result<T,AFError>)-> Void) {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: {
            JSONResponse in
            JSONResponse.timeoutInterval = 10
        }).validate(statusCode: 200..<201).responseDecodable(of: T.self) { responseDecodable in
            switch responseDecodable.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

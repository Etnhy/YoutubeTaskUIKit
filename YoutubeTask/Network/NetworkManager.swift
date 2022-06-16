//
//  NetworkManager.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import UIKit
import Alamofire

protocol NetworkLayerProtocol {
    func getYoutubePlaylist(playlistNumber: String,completion: @escaping (Result<Welcome, AFError>) -> ())
    func getViewsVideos(videoId: String,completion: @escaping (Result<YoutubeVideoResponse,AFError>) ->())
}

class NetworkManager {
    static let shared = NetworkManager()
    
    fileprivate let apiUrl = Configuration.Net.api_url
    fileprivate let apiKey = Configuration.Net.apiKey
    
    fileprivate let firstPlayList = Configuration.Playlists.first
    fileprivate let secondPlaylist = Configuration.Playlists.second
    
    
    func getYoutubePlaylist(playlistNumber: String ,completion: @escaping (Result<Welcome, AFError>) -> ()) {
        let url = "\(apiUrl)playlistItems?playlistId=\(playlistNumber)&maxResults=10&part=snippet%2CcontentDetails&key=\(apiKey)"
        downloadJson(url: url, completion: completion)
        // https://www.googleapis.com/youtube/v3/videos?part=statistics&id=h0ayziqKM9U&key=AIzaSyAvUBNHFqFgOKKUzN152a1z5bMkxW5wzwc
    }
    
    func getViewsVideos(videoId: String,completion: @escaping (Result<YoutubeVideoResponse,AFError>) ->()) {
        let url = "\(apiUrl)videos?part=statistics&id=\(videoId)&key=\(apiKey)"
        downloadJson(url: url, completion: completion)
    }
    
    
    
    
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
// MARK: - channels
//   'https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=UCpOrC2F6a6SswsBxGT0bJaA&id=UCf-M7ZMAeru8ubUHWQsxiVQ&id=UCnQHLFKsCRzyYTLJgA3Ud8Q&id=UCIgA09xiZmp-xxrcf_tFEVw&key=AIzaSyAvUBNHFqFgOKKUzN152a1z5bMkxW5wzwc


//https://www.googleapis.com/youtube/v3/playlistItems?playlistId=PLNZta_SFvNjFecxGDwyektG2-3LdgnhbD&maxResults=10&part=snippet%2CcontentDetails&key=AIzaSyAvUBNHFqFgOKKUzN152a1z5bMkxW5wzwc

//https://www.googleapis.com/youtube/v3/playlistItems?playlistId=PLNZta_SFvNjFecxGDwyektG2-3LdgnhbD&maxResults=10&part=snippet%2CcontentDetails&key=AIzaSyAvUBNHFqFgOKKUzN152a1z5bMkxW5wzwc

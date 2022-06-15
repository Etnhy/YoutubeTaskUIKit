//
//  NetworkManager.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import UIKit
import Alamofire

protocol NetworkLayerProtocol {
    func getYoutubePlaylist( completion: @escaping (Result<Welcome, AFError>) -> ())
}

class NetworkManager {
    static let shared = NetworkManager()
    
    fileprivate let apiUrl = Configuration.Net.api_url
    fileprivate let apiKey = Configuration.Net.apiKey
    
    fileprivate let firstPlayList = Configuration.Playlists.first
    fileprivate let secondPlaylist = Configuration.Playlists.second
    
    
    func getYoutubePlaylist(completion: @escaping (Result<Welcome, AFError>) -> ()) {
        let url = "\(apiUrl)playlistItems?playlistId=\(firstPlayList)&maxResults=10&part=snippet%2CcontentDetails&key=\(apiKey)"

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

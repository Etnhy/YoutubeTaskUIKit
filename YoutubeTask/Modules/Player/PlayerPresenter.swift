//
//  PlayerPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation


class PlayerPresenter: PlayerViewPresenterProtocol {

    
    var viewsToPlayer: [String] = []
    let networkManager: NetworkManager!
    
    weak var view: PlayerPresenterProtocol?
    var items: Welcome?
    var videoIdArray: [String] = []
    
    var videoIds: [GetVideoPlayerStruct] = []
    
    required init(view: PlayerPresenterProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
//        getVideoId()
    }
    
    func setPlayer(playlist: String) {
        DispatchQueue.main.async {
            self.networkManager.getPlaylistPromHeader(playlistId: playlist) { result in
                switch result {
                case .success(let response):
                    self.items = response
                    let playerModel = response.items.compactMap({
                        GetVideoPlayerStruct(position: $0.snippet.position ,videoId: $0.snippet.resourceId.videoId, titles: $0.snippet.title)
                    })
                    self.videoIdArray = response.items.map({$0.snippet.resourceId.videoId})
                    self.view?.configrePlayer(model: playerModel)
                case .failure(let error):
                    print(error)
                }
            }
            self.getVideoId()
        }
    }
    
    func getVideoId() {
        guard let items = items?.items else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            for i in items {
                self.networkManager.getViewsToPlayer(videoId: i.snippet.resourceId.videoId) { result in
                    switch result {
                    case .success(let views):
                        print(views.items)
                        let resultViews = views.items.map({$0.statistics.viewCount})
                        self.viewsToPlayer += resultViews
                        self.view?.setViews(self.viewsToPlayer)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
struct GetVideoPlayerStruct {
    var position:    Int
    var videoId:    String
    var titles:     String
//    var views:
}

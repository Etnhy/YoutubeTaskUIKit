//
//  PlayerPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

class PlayerPresenter: PlayerViewPresenterProtocol {
    var dispose = DisposeBag()
    
//    var viewsToPlayer: [String] = []
    let networkManager: NetworkManager!
    
    weak var view: PlayerPresenterProtocol?
    var items: Welcome?
    var videoIdArray: [String] = []
    
    var videoIds: [GetVideoPlayerStruct] = []
    
    required init(view: PlayerPresenterProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func setPlayer(playlist: String) {
        networkManager.getPlaylistPromHeader2(playlistId: playlist)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { items in
                self.items = items
                let playerModel = items.items.compactMap({
                    GetVideoPlayerStruct(position: $0.snippet.position ,videoId: $0.snippet.resourceId.videoId, titles: $0.snippet.title)
                })
                self.videoIdArray = items.items.map({$0.snippet.resourceId.videoId})
                self.view?.configrePlayer(model: playerModel)
            } onError: { error in
                print(error)
            } onCompleted: {
                self.view?.setViews(self.getVideoId())
            }
            .disposed(by: dispose)
    }
    
    func getVideoId(idArray: [String]? = []) -> [String] {
        var viewsArray: [String] = []
        guard let idArray = idArray else { return [] }
        if !idArray.isEmpty {
            for i in idArray {
                networkManager.getViewsToPlayer2(videoId: i)
                    .observe(on: MainScheduler.instance)
                    .subscribe { views in
                        let vi = views.items.map({ $0.statistics.viewCount})
                        viewsArray += vi
                        print(viewsArray)
                        self.view?.setViews(viewsArray)
                    } onError: { error in
                        print(error)
                    }.disposed(by: dispose)
            }

        } else {
            for i in items!.items {
                networkManager.getViewsToPlayer2(videoId: i.snippet.resourceId.videoId)
                    .observe(on: MainScheduler.instance)
                    .subscribe { views in
                        let vi = views.items.map({ $0.statistics.viewCount})
                        viewsArray += vi
                        self.view?.setViews(viewsArray)
                    } onError: { error in
                        print(error)
                    }.disposed(by: dispose)
            }

        }
        return viewsArray
    }
}


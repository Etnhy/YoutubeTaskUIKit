//
//  FirstPlaylistPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation
import RxSwift


class FirstPlaylistPresenter: FirstPlaylistViewProtocol {
    
    var welcome: [Items]?
    var dispose = DisposeBag()
    var youtubeVideoResponse: YoutubeVideoResponse!

    weak var view: FirstPlaylistProtocol?
    var networkManager: NetworkManager!
    required init(view: FirstPlaylistProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
        setFirst()
    }
    
    
    
    func setFirst() {
        networkManager.getYoutubePlaylist2(playlistNumber: Configuration.Playlists.first)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] items in
                guard let self = self else {return}
                self.welcome = items.items
                let model = self.welcome?.compactMap({
                    FirstCellModel(title: $0.snippet.title, image: $0.snippet.thumbnails.medium.url, linkId: $0.snippet.resourceId.videoId, playlistId: $0.snippet.playlistId)
                })
                self.view?.setPlaylist(model: model!)
            } onError: { error in
                print(error)
            } onCompleted: {
                self.setFirstViews()
            }
            .disposed(by: dispose)
    }
    
    func setFirstViews() {
        var firstViewsArray: [String] = []
        guard let welcome = welcome else { return }
        for i in welcome {
            networkManager.getViewsVideos2(videoId: i.snippet.resourceId.videoId)
                .observe(on: MainScheduler.instance)
                .subscribe { item in
                    let result = item.items.map({$0.statistics.viewCount})
                    firstViewsArray += result
                    self.view?.setViews(count: firstViewsArray)
                } onError: { error in
                    print(error)
                }onCompleted:{
                    print("views set")
                }.disposed(by: dispose)
        }
    }
}

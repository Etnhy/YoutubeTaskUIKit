//
//  SecondPlaylistPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation
import RxSwift

class SecondPlaylistPresenter: SecondPlaylistViewProtocol {

    let dispose = DisposeBag()
    var welcome: [Items]?
    weak var view: SecondPlaylistProtocol?
    var networkManager: NetworkManager!
    
    required init(view: SecondPlaylistProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
        setSecond()
    }
    
    func setSecond() {
        networkManager.getYoutubePlaylist2(playlistNumber: Configuration.Playlists.second)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] items in
                guard let self = self else {return}
                self.welcome = items.items
                let model = self.welcome?.compactMap({
                    SecondCellModel(title: $0.snippet.title, image: $0.snippet.thumbnails.medium.url, linkId: $0.snippet.resourceId.videoId, playlistId: $0.snippet.playlistId)
                })
                self.view?.setSecondPlaylist(model: model!)
            } onError: { error in
                print(error)
            } onCompleted: {
                self.setSecondViews()
            }
            .disposed(by: dispose)
    }
    
    func setSecondViews() {
        var secondViewsArray: [String] = []
        guard let welcome = welcome else { return }
        for i in welcome {
            networkManager.getViewsVideos2(videoId: i.snippet.resourceId.videoId)
                .observe(on: MainScheduler.instance)
                .subscribe { item in
                    let result = item.items.map({$0.statistics.viewCount})
                    secondViewsArray += result
                    self.view?.setSecondViews(count: secondViewsArray)
                } onError: { error in
                    print(error)
                }onCompleted:{
                    print("views set")
                }.disposed(by: dispose)
        }

//        guard let welcome = welcome else { return }
//        for i in welcome {
//            networkManager.getViewsVideos(videoId: i.snippet.resourceId.videoId ) { [weak self] video in
//                switch video {
//                case .success(let succes):
//                    let result = succes.items.map({$0.statistics.viewCount})
//                    self?.secondViewsArray += result
//                    self?.view?.setSecondViews(count: self!.secondViewsArray)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
    }
}

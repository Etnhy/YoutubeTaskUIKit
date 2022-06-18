//
//  FirstPlaylistPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation


class FirstPlaylistPresenter: FirstPlaylistViewProtocol {
    
    var firstViewsArray: [String] = []
    
    var welcome: [Items]?

    weak var view: FirstPlaylistProtocol?
    var networkManager: NetworkManager!
    required init(view: FirstPlaylistProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
        setFirst()
    }
    
    
    func setFirst() {
        DispatchQueue.main.async {
            self.networkManager.getYoutubePlaylist(playlistNumber: Configuration.Playlists.first) { [weak self] result in
                switch result {
                case .success(let succes):
                    self?.welcome = succes.items
                    let model = self?.welcome?.compactMap({
                        FirstCellModel(title: $0.snippet.title, image: $0.snippet.thumbnails.medium.url, linkId: $0.snippet.resourceId.videoId, playlistId: $0.snippet.playlistId)
                    })
                    self?.view?.setPlaylist(model: model!)
                case .failure(let error):
                    print(error)
                }
                self?.setFirstViews()
            }
        }
    }
    
    func setFirstViews() {
        guard let welcome = welcome else { return }
        for i in welcome {
            networkManager.getViewsVideos(videoId: i.snippet.resourceId.videoId ) { [weak self] video in
                switch video {
                case .success(let succes):
                    let result = succes.items.map({$0.statistics.viewCount})
                    self?.firstViewsArray += result
                    self?.view?.setViews(count: self!.firstViewsArray)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

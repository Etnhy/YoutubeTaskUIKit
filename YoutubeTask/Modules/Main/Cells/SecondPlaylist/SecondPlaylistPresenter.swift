//
//  SecondPlaylistPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation


class SecondPlaylistPresenter: SecondPlaylistViewProtocol {

    var secondViewsArray: [String] = []
    var welcome: [Items]?

    weak var view: SecondPlaylistProtocol?
    var networkManager: NetworkManager!
    
    required init(view: SecondPlaylistProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
        setSecond()
    }
    
    func setSecond() {
        DispatchQueue.main.async {
            self.networkManager.getYoutubePlaylist(playlistNumber: Configuration.Playlists.second) { [weak self] result in
                switch result {
                case .success(let succes):
                    self?.welcome = succes.items
                    let model = self?.welcome?.compactMap({
                        SecondCellModel(title: $0.snippet.title, image: $0.snippet.thumbnails.medium.url)
                    })
                    self?.view?.setSecondPlaylist(model: model!)
                case .failure(let error):
                    print(error)
                }
                self?.setSecondViews()
            }
        }
    }
    
    func setSecondViews() {
        guard let welcome = welcome else { return }
        for i in welcome {
            networkManager.getViewsVideos(videoId: i.snippet.resourceId.videoId ) { [weak self] video in
                switch video {
                case .success(let succes):
                    let result = succes.items.map({$0.statistics.viewCount})
                    self?.secondViewsArray += result
                    self?.view?.setSecondViews(count: self!.secondViewsArray)
                case .failure(let error):
                    print(error)
                }

            }
        }

    }
    
    
    
}

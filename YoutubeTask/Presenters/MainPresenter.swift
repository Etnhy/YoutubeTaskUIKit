//
//  MainPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 16.06.2022.
//

import Foundation

//protocol FirstPlaylistProtocol: AnyObject {
//    func setFirstPlaylist(model: [FirstCellModel])
//    func setFirsViews(count views: [ViewsModel])
//}
//
//protocol SecondPlaylistProtocol: AnyObject {
//
//}

protocol MainPlaylistProtocol: AnyObject {
    func setFirstPlaylist(model: [FirstCellModel])
    func setFirsViews(count views: [ViewsModel])
    
    func setSecondPlaylist(model: [SecondCellModel])
    func failure()
}

protocol MainPlaylistViewPresenterProtocol: AnyObject {
    init(view: MainPlaylistProtocol, networkManager: NetworkManager)
    var welcome: [Items]? { get set }
    func setFirst()
    func setFirstViews()
    
    func setSecond()
}

class MainPresenter: MainPlaylistViewPresenterProtocol {
    var firstModel  = [FirstCellModel]()
    var secondModel = [SecondCellModel]()
    
    var welcome: [Items]?
    var viewsCountModel: [ViewsModel]?
    var videoItemss: [VideoItems]?
    weak var view: MainPlaylistProtocol?
    
    
    let networkManager: NetworkManager!
    
    required init(view: MainPlaylistProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
//        setFirst()
    }
    
    

    func setFirst() {
        DispatchQueue.main.async {
            self.networkManager.getYoutubePlaylist(playlistNumber: Configuration.Playlists.first) { [weak self] result in
                switch result {
                case .success(let succes):
                    self?.welcome = succes.items
                    let model = self?.welcome?.compactMap({
                        FirstCellModel(title: $0.snippet.title, image: $0.snippet.thumbnails.medium.url)
                    })
                    self?.view?.setFirstPlaylist(model: model!)
                case .failure(let error):
                    print(error)
                }
                self?.setFirstViews()
                
            }

        }
    }
    
    func setFirstViews() {
//        for i in self.welcome {
//            networkManager.getViewsVideos(videoId: i.snippet.resourceId.videoId ) { [weak self] video in
//                switch video {
//                case .success(let succes):
//                    self?.videoItemss = succes.items
//
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
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
    //                print(model)
                    self?.view?.setSecondPlaylist(model: model!)
                case .failure(let error):
                    print(error)
                }
                self?.setFirstViews()
            }

        }

    }
}


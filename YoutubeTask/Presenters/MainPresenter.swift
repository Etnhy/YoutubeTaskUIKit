//
//  MainPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 16.06.2022.
//

import Foundation

protocol MainPlaylistProtocol: AnyObject {
    func setHeader(model: [HeaderModel])
    func setFirstPlaylist(model: [FirstCellModel])
    func setFirsViews(count views: [ViewsModel])
    func setSecondPlaylist(model: [SecondCellModel])
    func failure()
}
//protocol BlockProtocols: AnyObject {
//    let header : HeaderPlaylistProtocl
//    let first   : FirstPlaylistProtocol
//    let second  : Secon
//}

protocol MainPlaylistViewPresenterProtocol: AnyObject {
    init(view: MainPlaylistProtocol, networkManager: NetworkManager)
    var welcome: [Items]? { get set }
    
    func setChannels()
    
    func setFirst()
    func setFirstViews()
    
    func setSecond()
    func setSecondViews()
    func fetchGroup()
}

class MainPresenter: MainPlaylistViewPresenterProtocol {


    

    var headerModel = [HeaderModel]()
    var firstModel  = [FirstCellModel]()
    var secondModel = [SecondCellModel]()
    
    var youtubeChannelModel: [YoutubeChannelItems]?
    var welcome: [Items]?
    var viewsCountModel: [ViewsModel]?
    var videoItemss: [VideoItems]?
    weak var view: MainPlaylistProtocol?
    
    
    let networkManager: NetworkManager!
    
    required init(view: MainPlaylistProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
//        setFirst()
//        setChannels()
        fetchGroup()
    }
    
    // MARK: - fetch group
    func fetchGroup() {
        let group = DispatchGroup()
        
        group.enter()
        setChannels()
        group.leave()
        
        group.enter()
        setFirst()
        group.leave()
        
        group.enter()
        setSecond()
        group.leave()
        
        group.notify(queue: .main) {
            print("loading is done")
        }
        
    }
    
    func setChannels() {
        print("channels")
        networkManager.getChannels { [weak self] result in
            switch result {
            case .success(let channels):
                self?.youtubeChannelModel = channels.items
                let model = self?.youtubeChannelModel?.compactMap({
                    HeaderModel(channelNames: $0.snippet.title, subscribersCount: $0.statistics.subscriberCount, channelImgage: $0.snippet.thumbnails.high.url, playlist: $0.contentDetails.relatedPlaylists.uploads)
                })
                self?.view?.setHeader(model: model!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func setFirst() {
        print("setfirst")
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
        setFirstViews()
    }
    
    func setFirstViews() {
        print("first views")
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
//        setSecond()
    }
    func setSecond() {
        print("setSecond")
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
                self?.setFirstViews()
            }
        }
        setFirstViews()
    }
    func setSecondViews() {
        print("second views")
    }
    
}


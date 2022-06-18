//
//  HeaderPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation


class HeaderPresenter: HeaderViewProtocol {
    var youtubeChannelItems: [YoutubeChannelItems]?
    weak var view: HeaderProtocol?
    var networkManager: NetworkManager!
    
    required init(view: HeaderProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
        setChannels()
    }
    
    func setChannels() {
                networkManager.getChannels { [weak self] result in
                    switch result {
                    case .success(let channels):
                        self?.youtubeChannelItems = channels.items
                        let model = self?.youtubeChannelItems?.compactMap({
                            HeaderModel(channelNames: $0.snippet.title, subscribersCount: $0.statistics.subscriberCount, channelImgage: $0.snippet.thumbnails.high.url,
                                        playlist: $0.contentDetails.relatedPlaylists.uploads)
                        })
                        self?.view?.setHeader(model: model!)
                    case .failure(let error):
                        print(error)
                    }
                }
    }
}

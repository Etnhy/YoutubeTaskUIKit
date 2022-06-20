//
//  HeaderPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation
import RxSwift


class HeaderPresenter: HeaderViewProtocol {
    
    let dispose = DisposeBag()
    var youtubeChannelItems: [YoutubeChannelItems]?
    weak var view: HeaderProtocol?
    var networkManager: NetworkManager!
    
    required init(view: HeaderProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
        setChannels()
    }
    
    // MARK: - Set Channels
    func setChannels() {
        networkManager.getChannels()
            .observe(on: MainScheduler.instance)
            .subscribe { item in
                self.youtubeChannelItems = item.items
                let model = self.youtubeChannelItems?.compactMap({
                    HeaderModel(channelNames: $0.snippet.title, subscribersCount: $0.statistics.subscriberCount, channelImgage: $0.snippet.thumbnails.high.url,
                                playlist: $0.contentDetails.relatedPlaylists.uploads)
                })
                self.view?.setHeader(model: model!)
            } onError: { error in
                print(error)
            }
            .disposed(by: dispose)
    }
}

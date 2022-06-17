//
//  HeaderContract.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation

protocol HeaderProtocol: AnyObject {
    func setHeader(model: [HeaderModel])
}

protocol HeaderViewProtocol: AnyObject {
    init(view:HeaderProtocol,networkManager: NetworkManager)
    var youtubeChannelItems: [YoutubeChannelItems]? { get set }
    func setChannels()
}

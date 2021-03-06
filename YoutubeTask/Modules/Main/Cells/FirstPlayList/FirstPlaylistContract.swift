//
//  FirstPlaylistContract.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation

// MARK: - First playlist presenter protocols
protocol FirstPlaylistProtocol: AnyObject {
    func setPlaylist(model: [FirstCellModel])
    func setViews(count views: [String])
}

protocol FirstPlaylistViewProtocol: AnyObject {
    init(view: FirstPlaylistProtocol, networkManager: NetworkManager)
    var welcome: [Items]? { get set }
    
    func setFirst()
    func setFirstViews()
}

// MARK: -  Send from first playlis
protocol SendFromFirstPlaylist: AnyObject {
    func send(playerModel: ShowPlayerModel)
}

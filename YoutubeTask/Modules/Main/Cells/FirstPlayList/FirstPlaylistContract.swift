//
//  FirstPlaylistContract.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation

protocol FirstPlaylistProtocol: AnyObject {
    func setPlaylist(model: [FirstCellModel])
    func setViews(count views: [String])
}

protocol FirstPlaylistViewProtocol: AnyObject {
    init(view: FirstPlaylistProtocol, networkManager: NetworkManager)
    var firstViewsArray: [String] { get set }
    var welcome: [Items]? { get set }
    
    func setFirst()
    func setFirstViews()
}

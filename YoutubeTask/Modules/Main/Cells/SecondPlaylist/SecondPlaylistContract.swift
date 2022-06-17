//
//  SecondPlaylistContract.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation

protocol SecondPlaylistProtocol: AnyObject {
    func setSecondPlaylist(model: [SecondCellModel])
    func setSecondViews(count views: [String])
}

protocol SecondPlaylistViewProtocol: AnyObject {
    init(view: SecondPlaylistProtocol, networkManager: NetworkManager)
    var secondViewsArray: [String] { get set }
    var welcome: [Items]? { get }
    
    func setSecond()
    func setSecondViews()
}

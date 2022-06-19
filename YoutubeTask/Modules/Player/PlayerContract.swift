//
//  PlayerContract.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 19.06.2022.
//

import Foundation

// MARK: - Player presenter protocols
protocol PlayerPresenterProtocol: AnyObject {
    func configrePlayer(model: [GetVideoPlayerStruct])
    func setViews(_ views: [String])
}

protocol PlayerViewPresenterProtocol: AnyObject {
    init(view:PlayerPresenterProtocol, networkManager: NetworkManager)
    func setPlayer(playlist: String)
    func getVideoId()
    
//    var videoName: String { get set }
}

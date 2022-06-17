//
//  PlayerPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 17.06.2022.
//

import Foundation

protocol PlayerPresenterProtocol: AnyObject {
    func setPlayer()
}

protocol PlayerViewPresenterProtocol: AnyObject {
    init(view:PlayerPresenterProtocol)
    func setPlayer()
    var videoName: String { get set }
}

class PlayerPresenter: PlayerViewPresenterProtocol {
    var videoName: String = " "

    weak var view: PlayerPresenterProtocol?
    required init(view: PlayerPresenterProtocol) {
        self.view = view
        setPlayer()
    }
    
    func setPlayer() {
        print("player")
//        print(videoName)

    }
    
    
}
extension PlayerPresenter: SendVideoName {
    func testcall(_ name: String) {
        self.videoName = name
        print(name)
    }
}

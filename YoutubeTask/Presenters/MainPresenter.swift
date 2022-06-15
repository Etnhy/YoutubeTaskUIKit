//
//  MainPresenter.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 16.06.2022.
//

import Foundation

protocol MainPlaylistProtocol: AnyObject {
    func succes()
    func failure()
}

protocol MainPlaylistViewPresenterProtocol: AnyObject {
    init(view: MainPlaylistProtocol, networkManager: NetworkManager)
    func set()
    var welcome: [Welcome]? { get set }
}

class MainPresenter: MainPlaylistViewPresenterProtocol {
    
    var welcome: [Welcome]?
    weak var view: MainPlaylistProtocol?
    let networkManager: NetworkManager!
    
    required init(view: MainPlaylistProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func set() {
        print("haloo")
    }
}

struct FirstCellModel {
    var title: String
}

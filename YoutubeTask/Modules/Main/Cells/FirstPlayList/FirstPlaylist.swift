//
//  FirstPlaylistCell.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit
import RxSwift
import RxCocoa


class FirstPlaylist: UITableViewCell {
    static let identifier = "FirstPlaylist"
    
    weak var sendId: SendFromFirstPlaylist?
    var model = [FirstCellModel]()
    let network = NetworkManager()
    var presenter: FirstPlaylistViewProtocol?
    var viewsCont = [String]()

    
    let firstPlaylistName: UILabel = {
        var name = UILabel()
        name.text = "FirstPlaylist name"
        name.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        name.textColor = .white
        return name
    }()
    
    lazy var firstPlaylistCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(FirstPlayerCollectionCell.self, forCellWithReuseIdentifier: FirstPlayerCollectionCell.identifier)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .black
        return collection
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
        addSubviews()
    }
    
    fileprivate func setupView() {
        self.presenter = FirstPlaylistPresenter(view: self, networkManager: network)
    }
    
    fileprivate func addSubviews() {
        self.addSubview(firstPlaylistCollectionView)
        self.addSubview(firstPlaylistName)
        activateConstraints()
    }
    
   fileprivate func activateConstraints() {
        firstPlaylistName.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self).offset(16)
        }
        firstPlaylistCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstPlaylistName.snp.bottom)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FirstPlaylist: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstPlayerCollectionCell.identifier, for: indexPath) as? FirstPlayerCollectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: model[indexPath.row])
            cell.setViews(views: viewsCont[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let linkLoad = model[indexPath.row].linkId
        let name = model[indexPath.row].title
        let playlistId = model[indexPath.row].playlistId
        let viewss = viewsCont[indexPath.row]
        let playerModel = ShowPlayerModel(songTitle: name, viewsCount: viewss, playlistId: playlistId!, loadLink: linkLoad)
        self.sendId?.send(playerModel: playerModel)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FirstPlaylist: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 130)
    }
}

// MARK: - FirstPlaylistProtocol
extension FirstPlaylist: FirstPlaylistProtocol {
    func setPlaylist(model: [FirstCellModel]) {
        self.model = model
    }
    
    func setViews(count views: [String]) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.viewsCont = views
            self.firstPlaylistCollectionView.reloadData()
        }
    }
}

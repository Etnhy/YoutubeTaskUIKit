//
//  SecondPlaylistCell.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit
import SnapKit

class SecondPlaylist: UITableViewCell {
    
    var secondModel = [SecondCellModel]()
    var secondViewsArray: [String] = []
    let network = NetworkManager()
    var presenter: SecondPlaylistViewProtocol?
//    var presenter: MainPlaylistViewPresenterProtocol?

    let secondPlaylistName: UILabel = {
        var name = UILabel()
        name.text = "SecondPlaylist name"
        name.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        name.textColor = .white
        return name
    }()
    
    lazy var secondPlaylistCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(SecondPlayerCollectionCell.self, forCellWithReuseIdentifier: SecondPlayerCollectionCell.idenrifier)
        collection.backgroundColor = .black
        return collection
    }()
    
    static let identifier = "SecondPlaylistCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureView()
    }
    
    fileprivate func configureView() {
//        self.presenter = MainPresenter(view: self, networkManager: network)
        self.presenter = SecondPlaylistPresenter(view: self, networkManager: network)
        addSubview(secondPlaylistName)
        addSubview(secondPlaylistCollectionView)
        
        activateConstraints()
    }
    
    
    fileprivate func activateConstraints() {
        secondPlaylistName.snp.makeConstraints { make in
            make.top.equalTo(self).offset(2)
            make.leading.equalTo(self).offset(16)
        }
        secondPlaylistCollectionView.snp.makeConstraints { make in
            make.top.equalTo(secondPlaylistName.snp.bottom).offset(0)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
}

extension SecondPlaylist: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return secondModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondPlayerCollectionCell.idenrifier, for: indexPath) as? SecondPlayerCollectionCell else  {
            return UICollectionViewCell()
        }
        cell.configure(with: secondModel[indexPath.row])
        
        if secondViewsArray.count == secondModel.count {
            cell.setViews(views: secondViewsArray[indexPath.row])
        }
        cell.backgroundColor = .clear
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 220)
    }
    
}
extension SecondPlaylist: UICollectionViewDelegateFlowLayout {
    
}

extension SecondPlaylist: SecondPlaylistProtocol {
    func setSecondPlaylist(model: [SecondCellModel]) {
        self.secondModel = model
    }
    
    func setSecondViews(count views: [String]) {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.secondViewsArray = views
            self.secondPlaylistCollectionView.reloadData()
        }
    }
    
    
}
//extension SecondPlaylist: MainPlaylistProtocol {
//    func setSecondViews(count views: [String]) {
//        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//            self.secondViewsArray = views
//            print(views)
//            self.secondPlaylistCollectionView.reloadData()
//        }
//    }
//
//    func setHeader(model: [HeaderModel]) {
//        ///
//    }
//
//    func setFirstPlaylist(model: [FirstCellModel]) {
//        ///
//    }
//
//    func setFirsViews(count views: [String]) {
//        ///
//    }
//
//    func setSecondPlaylist(model: [SecondCellModel]) {
//        self.secondModel = model
//        self.secondPlaylistCollectionView.reloadData()
//    }
//
//    func failure() {
//        ///
//    }
//
//
//}

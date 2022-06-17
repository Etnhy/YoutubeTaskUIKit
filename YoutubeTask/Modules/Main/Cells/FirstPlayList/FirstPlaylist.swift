//
//  FirstPlaylistCell.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit

protocol SendVideoName: AnyObject {
    func testcall(_ name: String)
}

class FirstPlaylist: UITableViewCell {

    static let identifier = "FirstPlaylist"
    
    var model = [FirstCellModel]()
    
    var viewsCont = [ViewsModel]()
    var presenter: MainPlaylistViewPresenterProtocol?
    var delegate: SendVideoName!

    
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        setupView()
        addSubviews()
    }
    
    func setupView() {
        let network = NetworkManager()
        self.presenter = MainPresenter(view: self, networkManager: network)

    }
    func addSubviews() {
        self.addSubview(firstPlaylistCollectionView)
        self.addSubview(firstPlaylistName)
        activateConstraints()
    }
    func activateConstraints() {
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

extension FirstPlaylist: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstPlayerCollectionCell.identifier, for: indexPath) as? FirstPlayerCollectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: model[indexPath.row])
//        cell.setViews(views: viewsCont[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoName = "GAGAGAGGAG"

        
    }
    
    
}

extension FirstPlaylist: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 130)
    }
}
extension FirstPlaylist: MainPlaylistProtocol {
    
    func setFirsViews(count views: [ViewsModel]) {
        self.viewsCont = views
    }

    func setFirstPlaylist(model: [FirstCellModel]) {
        self.model = model
        self.firstPlaylistCollectionView.reloadData()
    }
    
    func setHeader(model: [HeaderModel]) {
        ///
    }
    
    func setSecondPlaylist(model: [SecondCellModel]) {
        ///
    }
    func failure() {
        ///
    }
}

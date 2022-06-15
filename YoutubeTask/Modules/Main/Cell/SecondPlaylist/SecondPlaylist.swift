//
//  SecondPlaylistCell.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit
import SnapKit

class SecondPlaylist: UITableViewCell {
    
    
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
        addSubview(secondPlaylistName)
        addSubview(secondPlaylistCollectionView)
        
        activateConstraints()
    }
    
    
    fileprivate func activateConstraints() {
        secondPlaylistName.snp.makeConstraints { make in
            make.top.equalTo(self).offset(24)
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondPlayerCollectionCell.idenrifier, for: indexPath) as? SecondPlayerCollectionCell else  {
            return UICollectionViewCell()
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
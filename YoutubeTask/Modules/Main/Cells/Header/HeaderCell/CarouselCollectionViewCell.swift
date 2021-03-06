//
//  CarouselCollectionViewCell.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit
import AlamofireImage

class CarouselCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CarouselCollectionViewCell"
    
    var uploads: String = ""
    var buttonHeight:CGFloat = 70
    let bannerImage: UIImageView = {
       var img = UIImageView()
        img.backgroundColor = .orange
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 8
        return img
    }()

    let albumName: UILabel = {
       var albumName = UILabel()
        albumName.text = "Album name"
        albumName.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        albumName.textColor = .white
        return albumName
    }()
    
    let subscribersCount: UILabel = {
        var subCount = UILabel()
        subCount.text = "123456 подписчиков"
        subCount.textColor = .gray
        subCount.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return subCount
    }()
    
    let playButton: UIButton = {
        var button = UIButton(type: .system)
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "Play")
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        button.clipsToBounds = true
        button.layer.cornerRadius = 35
        button.backgroundColor = .purple
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        playButton.layer.cornerRadius = buttonHeight / 2
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.layer.cornerRadius = 8
        addSubview(bannerImage)
        addSubview(albumName)
        addSubview(subscribersCount)
        addSubview(playButton)
        activateConstraints()
    }
    
    func configure(with model: HeaderModel) {
        self.albumName.text = model.channelNames
        self.subscribersCount.text = "\(model.subscribersCount) подписчика."
        self.uploads = model.playlist
        guard let url = URL(string: "\(model.channelImgage)") else { return }
        self.bannerImage.af.setImage(withURL: url)
    }

    
    func activateConstraints() {
        bannerImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.trailing.equalTo(self)
        }
        
        albumName.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(16)
            make.bottom.equalTo(self).offset(-44)
        }
        
        subscribersCount.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(16)
            make.top.equalTo(albumName.snp.bottom)
        }
        
        playButton.snp.makeConstraints { make in
            make.top.equalTo(self).offset(18)
            make.leading.equalTo(self).offset(16)
            make.size.equalTo(CGSize(width: buttonHeight, height: buttonHeight))
        }
    }
}

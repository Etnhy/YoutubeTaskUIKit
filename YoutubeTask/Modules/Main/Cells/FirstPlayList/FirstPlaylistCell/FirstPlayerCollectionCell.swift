//
//  FirstPlayerCollectionCell.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit
import AlamofireImage

class FirstPlayerCollectionCell: UICollectionViewCell {
    
    static let identifier = "FirstPlayerCollectionCell"
    

    
    let firstPlaylistImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "ttew.png")
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Meteora MeteoraMeteora"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    let viewsCount: UILabel = {
        var label = UILabel()
//        label.text = "123312412 "
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 8
        addSubview(firstPlaylistImage)
        addSubview(nameLabel)
        addSubview(viewsCount)
        activateConstraints()
    }
    
    func configure(with model: FirstCellModel) {
        self.nameLabel.text = model.title
        guard let urlImg = URL(string: model.image) else { return }
        self.firstPlaylistImage.af.setImage(withURL: urlImg)
    }
    
    func setViews(views: String) {
        self.viewsCount.text = "\(views) просмотров."
    }
    
    func activateConstraints() {
        firstPlaylistImage.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(70)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(firstPlaylistImage.snp.bottom).offset(18)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)

        }
        viewsCount.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

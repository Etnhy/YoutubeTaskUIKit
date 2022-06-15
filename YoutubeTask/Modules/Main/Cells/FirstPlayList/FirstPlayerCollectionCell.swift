//
//  FirstPlayerCollectionCell.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit

class FirstPlayerCollectionCell: UICollectionViewCell {
    
    static let identifier = "FirstPlayerCollectionCell"
    
    let firstPlaylistImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "recc.png")
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Meteora"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white

        return label
    }()
    
    let viewsCount: UILabel = {
        var label = UILabel()
        label.text = "123312412 просмотров"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        addSubview(firstPlaylistImage)
        addSubview(nameLabel)
        addSubview(viewsCount)
        activateConstraints()
    }
    
    func configure(with model: FirstCellModel) {
        self.nameLabel.text = model.title
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
        }
        viewsCount.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

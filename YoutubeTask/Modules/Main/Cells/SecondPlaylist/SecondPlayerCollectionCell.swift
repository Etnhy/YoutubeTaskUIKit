//
//  SecondPlayerCollectionCell.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import UIKit

class SecondPlayerCollectionCell: UICollectionViewCell {
    static let idenrifier = "SecondPlayerCollectionCell"
    
    
    let secondPlaylistImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "recc.png")
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
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
        label.text = "1 848 894 просмотра"
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
        addSubview(secondPlaylistImage)
        addSubview(nameLabel)
        addSubview(viewsCount)
        activateConstraints()
    }
    
    func activateConstraints() {

        secondPlaylistImage.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(self.frame.size.width - 10)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(secondPlaylistImage.snp.bottom).offset(8)
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

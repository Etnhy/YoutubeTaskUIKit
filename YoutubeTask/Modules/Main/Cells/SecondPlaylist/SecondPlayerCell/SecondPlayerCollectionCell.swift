//
//  SecondPlayerCollectionCell.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import UIKit
import AlamofireImage

class SecondPlayerCollectionCell: UICollectionViewCell {
    static let idenrifier = "SecondPlayerCollectionCell"
    
    let secondPlaylistImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "ttew.png")
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.text = "Eternal rest two trwo tw"
        return label
    }()
    
    let viewsCount: UILabel = {
        var label = UILabel()
        label.text = "1 848 894 просмотра"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func configure(with model: SecondCellModel) {
        self.nameLabel.text = model.title
        guard let urlImg = URL(string: model.image) else { return }
        self.secondPlaylistImage.af.setImage(withURL: urlImg)
    }
    
    func setViews(views: String) {
        self.viewsCount.text = "\(views) просмотров"
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
            make.trailing.equalTo(self)
            make.height.equalTo(40)
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

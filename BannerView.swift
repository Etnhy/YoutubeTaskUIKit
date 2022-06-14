//
//  BannerView.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit
import SnapKit

class BannerView: UIView {
    
    lazy var topCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .gray
        view.register(BannerViewCell.self, forCellWithReuseIdentifier: BannerViewCell.identifier)
        return view
    }()

    let pageControl: UIPageControl = {
       var pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.backgroundColor = .blue
        return pageControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK: - Setup view
    private func setupView() {
        
    
    addSubviews()
    }
    
    
    // MARK: - AddSubviews
    private func addSubviews() {
        addSubview(pageControl)
        
        addSubview(topCollection)
        activateConstraints()
    }
    
    // MARK: - Constraints
    private func activateConstraints() {
        topCollection.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(300)
        }
        
//        pageControl.snp.makeConstraints { make in
//            make.bottom.equalTo(self)
//            make.leading.trailing.equalTo(self)
//            make.height.equalTo(60)
//        }
    }
    

}

extension BannerView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerViewCell.identifier, for: indexPath) as? BannerViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

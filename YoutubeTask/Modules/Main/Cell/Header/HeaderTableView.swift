//
//  HeaderTableView.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit

class HeaderTableView: UITableViewHeaderFooterView {
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    lazy var carouselView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        view.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.identifier)
        return view
    }()
    
    let pageControl: UIPageControl = {
       var pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.backgroundColor = .black
        return pageControl
    }()
    
    static let identifier = "HeaderTableView"

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureView() {
        self.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.layer.cornerRadius = 8
        
        addSubview(carouselView)
        addSubview(pageControl)
        activateConstraints()
    }
    
    fileprivate func activateConstraints() {
        carouselView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.trailing.leading.equalTo(self)
            make.height.equalTo(220)
        }
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(carouselView.snp.bottom)
            make.leading.trailing.equalTo(self)
//            make.height.equalTo(40)
            make.bottom.equalTo(self)
        }
    }
    
    func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: carouselView.contentOffset, size: carouselView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }

}

extension HeaderTableView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as? CarouselCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .clear
        return cell
    }
    
//    collectionview
    
}

extension HeaderTableView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 220)
    }
    
    
    /*          pageControl = currentpage        */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

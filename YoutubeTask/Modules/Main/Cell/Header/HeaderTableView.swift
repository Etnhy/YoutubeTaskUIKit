//
//  HeaderTableView.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit

class HeaderTableView: UITableViewHeaderFooterView {
    
    var carousalTimer: Timer?
    var newOffsetX: CGFloat = 0.0

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
        view.isPagingEnabled = true
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
//        startTimer()
        setTimer()
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
    
    @objc
    fileprivate func moveToNextPage() {
        let pageWidth: CGFloat = self.carouselView.frame.width
        let maxWidth: CGFloat = pageWidth * 4
        let contentOffset: CGFloat = self.carouselView.contentOffset.x

        var swipeToX = contentOffset + pageWidth

        if contentOffset + pageWidth == maxWidth   {
            swipeToX = 0
        }
        self.carouselView.scrollRectToVisible(
            CGRect(x: swipeToX, y: 0, width: pageWidth, height: self.carouselView.frame.height),
                                              animated: true)
    }
    func startTimer() {
            carousalTimer = Timer(fire: Date(), interval: 0.015, repeats: true) { (timer) in
                let initailPoint = CGPoint(x: self.newOffsetX,y :0)
                if __CGPointEqualToPoint(initailPoint, self.carouselView.contentOffset) {
                    if self.newOffsetX < self.carouselView.contentSize.width {
                        self.newOffsetX += 0.25
                    }
                    if self.newOffsetX > self.carouselView.contentSize.width - self.carouselView.frame.size.width {
                        self.newOffsetX = 0
                    }
                    self.carouselView.contentOffset = CGPoint(x: self.newOffsetX,y :0)

                } else {
                    self.newOffsetX = self.carouselView.contentOffset.x
                }
            }
            RunLoop.current.add(carousalTimer!, forMode: .common)
    }
    func setTimer() {
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)

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

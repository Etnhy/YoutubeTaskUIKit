//
//  ShowPlayerViewButton.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 18.06.2022.
//

import Foundation
import UIKit
import SnapKit

class ShowPlayerViewButton: UIView {
    
    private var size = CGSize()
    fileprivate var buttonIsTapped: Bool = false
    
    lazy var showButton: UIButton = {
        var button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "Close_Open")?.rotated(byDegrees: 180)
        button.configuration = config
        button.layer.cornerRadius = 18
        button.backgroundColor = .clear
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(changeStateButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addGradient(colors: [UIColor.buttonGradientStart(), UIColor.buttonGradientEnd()])

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: self.frame.size.height / 3, height: self.frame.size.height )).cgPath
        layer.mask = shapeLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup view
    private func setupView() {
        self.backgroundColor = .systemPink
        addSubviews()
    }
    
    // MARK: - AddSubviews
    private func addSubviews() {
        addSubview(showButton)
        activateConstraints()
    }
    
    // MARK: -  Actions
    @objc fileprivate func changeStateButton() {
        buttonIsTapped.toggle()
        var config = UIButton.Configuration.plain()
        config.image = buttonIsTapped ? UIImage(named: "Close_Open")?.rotated(byDegrees: 180) : UIImage(named: "Close_Open")
        showButton.configuration = config
    }
    
    // MARK: - Constraints
    private func activateConstraints() {
        showButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
}

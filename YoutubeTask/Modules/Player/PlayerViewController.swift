//
//  PlayerViewController.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    
    let buttonName = ["Prev","Pause","Next"]

    
    lazy var playerView: UIView = {
       var view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    let progressView: UIProgressView = {
        var progress = UIProgressView()
        progress.progressViewStyle = .default
        
        progress.setProgress(0.1, animated: true)
        progress.progressTintColor = .white
        progress.trackTintColor = .gray
        return progress
    }()
    
    let videoName: UILabel = {
       var videoName = UILabel()
        videoName.text = "Mondo Marcio - Angeli e Debroni"
        videoName.textAlignment = .center
        videoName.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        videoName.textColor = .white
        return videoName
    }()
    
    let viewsCount: UILabel = {
       var count = UILabel()
        count.text = "1 848 894 просмотра"
        count.textAlignment = .center
        count.textColor = .white.withAlphaComponent(0.7)
        return count
    }()
    
    lazy var playerButtons: [UIButton] = {
        var buttons: [UIButton] = []
//        buttonName.forEach { name in
            for (index, buttName) in buttonName.enumerated() {
            var button = UIButton(type: .system)
            var config = UIButton.Configuration.plain()
            config.image = UIImage(named: buttName)
            config.background.backgroundColor = .clear
            button.configuration = config
                button.tag = index
            button.addTarget(self, action: #selector(buttonPlayerActions(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        return buttons
    }()

    lazy var buttonStackView: UIStackView = {
    var stack = UIStackView(arrangedSubviews: playerButtons)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    let volumeSlider: UISlider = {
       var slider = UISlider()
        slider.thumbTintColor = .white
        slider.maximumTrackTintColor = .gray.withAlphaComponent(0.7)
        slider.tintColor = .white
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    fileprivate func configureView() {
//        view.backgroundColor = .systemPink
        setGradiend()
        view.addSubview(progressView)
        view.addSubview(playerView)
        view.addSubview(videoName)
        view.addSubview(viewsCount)
        view.addSubview(buttonStackView)
        view.addSubview(volumeSlider)
        
        activateConstraints()
    }
    @objc func buttonPlayerActions(_ sender: UIButton) {
        switch sender.tag {
        case 0: print("back")
        case 1: print("pause")
        case 2: print("next")
        default: break
        }
    }
    fileprivate func activateConstraints() {
        playerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view).offset(4)
            make.trailing.equalTo(view).offset(-4)
            make.height.equalTo(260)
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(playerView.snp.bottom).offset(16)
            make.leading.equalTo(view).offset(8)
            make.trailing.equalTo(view).offset(-8)
            make.height.equalTo(10)
        }
        videoName.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(40)
            make.leading.equalTo(view).offset(60)
            make.trailing.equalTo(view).offset(-60)
            make.height.equalTo(40)
        }
        viewsCount.snp.makeConstraints { make in
            make.top.equalTo(videoName.snp.bottom).offset(4)
            make.centerX.equalTo(videoName)
        }
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(viewsCount.snp.bottom).offset(50)
            make.leading.equalTo(view).offset(74)
            make.trailing.equalTo(view).offset(-74)
            make.height.equalTo(64)
        }
        volumeSlider.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(80)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(15)
        }
    }

}

extension PlayerViewController {
    func setGradiend() {
        let startPointX: CGFloat = 1
        let startPointY: CGFloat = 0
        
        let endPointX: CGFloat = 0
        let endPointY: CGFloat = 1
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.buttonGradientStart().cgColor, UIColor.buttonGradientEnd().cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint   = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.frame = self.view.bounds
        self.view.layer.addSublayer(gradientLayer)
    }
}






import SwiftUI

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewControlle = PlayerViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewControlle
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
}

//
//  PlayerViewController.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import UIKit
import youtube_ios_player_helper

class PlayerViewController: UIViewController {

    let buttonName = ["Prev","Play","Next"]
    var playerIsVisible: Bool = true
    var playVideos: Bool = false

    var videoNameText: String = "" {
        willSet {
            self.videoName.text = videoNameText
        }
    }
    
    lazy var showViewButton: UIButton = {
        var button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "Close_Open")?.rotated(byDegrees: 180)
        button.configuration = config
        button.addTarget(self, action: #selector(imageChanger), for: .touchUpInside)
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        return button
    }()
    
    lazy var playerView: YTPlayerView = {
       var view = YTPlayerView()
//        view.load(withVideoId: "GJzUu8ZjsCA")
        view.load(withPlaylistId: Configuration.Playlists.first)
        view.backgroundColor = .black
//        view.
        
        return view
    }()
    
    let progressView: UIProgressView = {
        var progress = UIProgressView()
        progress.progressViewStyle = .bar
        
//        progress.setProgress(0.0, animated: true)
//        progress
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
    
    lazy var volumeSlider: UISlider = {
       var slider = UISlider()
        slider.thumbTintColor = .white
        slider.maximumTrackTintColor = .gray.withAlphaComponent(0.7)
        slider.tintColor = .white
        slider.addTarget(self, action: #selector(changeVolume(_:)), for: .valueChanged)
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        return slider
    }()
   
    
     init(songTitle: String, viewsCount: String) {
         super.init(nibName: nil, bundle: nil)
         self.videoName.text = songTitle
         self.viewsCount.text = "\(viewsCount) просмотра"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
//        setProgress()
        Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
    }
    
   @objc func setProgress() {
       playerView.currentTime()
       self.playerView.currentTime { progress, _ in
           self.progressView.setProgress(progress / 261, animated: true)
       }
        
    }
    fileprivate func configureView() {
        self.view.layer.cornerRadius = 18
        self.view.clipsToBounds = true
        view.addSubview(showViewButton)
        view.addSubview(progressView)
        view.addSubview(playerView)
        view.addSubview(videoName)
        view.addSubview(viewsCount)
        view.addSubview(buttonStackView)
        view.addSubview(volumeSlider)
        view.addGradient(colors: [UIColor.buttonGradientStart(), UIColor.buttonGradientEnd()])
        activateConstraints()
    }
    @objc func buttonPlayerActions(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            playerView.previousVideo()
        case 1:
            playVideos.toggle()

            var config = UIButton.Configuration.plain()
            config.image = playVideos ? UIImage(named: "Pause") : UIImage(named: "Play")
            playerButtons[1].configuration = config
            if playVideos {
                playerView.playVideo()
            } else {
                playerView.pauseVideo()
            }
        case 2:
            playerView.nextVideo()
        default: break
        }
    }
    
    @objc func imageChanger() {
        playerIsVisible.toggle()
        var config = UIButton.Configuration.plain()
        config.image = playerIsVisible ? UIImage(named: "Close_Open")?.rotated(byDegrees: 180) : UIImage(named: "Close_Open")
        
        showViewButton.configuration = config
    }
    @objc func changeVolume(_ sender: UISlider) {
        
    }
    fileprivate func activateConstraints() {

        showViewButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(6)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(40)
        }
        
        playerView.snp.makeConstraints { make in
            make.top.equalTo(showViewButton.snp.bottom).offset(8)
            make.leading.equalTo(view).offset(4)
            make.trailing.equalTo(view).offset(-4)
            make.height.equalTo(240)
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
            make.top.equalTo(viewsCount.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(74)
            make.trailing.equalTo(view).offset(-74)
            make.height.equalTo(64)
        }
        volumeSlider.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(20)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(15)
        }
    }
}


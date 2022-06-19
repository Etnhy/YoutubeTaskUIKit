//
//  PlayerViewController.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 15.06.2022.
//

import UIKit
import youtube_ios_player_helper

protocol ShowButtonDelegate: AnyObject {
    func setShow(_ bool: Bool)
}
class PlayerViewController: UIViewController {

    weak var delegate: ShowButtonDelegate?
    var presenter: PlayerViewPresenterProtocol?

    let buttonName = ["Prev","Play","Next"]
    var playerIsVisible: Bool = true
    var playVideos:      Bool = false
    var videoNameText: String = "" {
        willSet {
            self.videoName.text = videoNameText
        }
    }

    let containerView: UIView = {
       var view = UIView()
        view.addGradient()
        view.layer.cornerRadius = 12
        return view
    }()
    
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
        view.backgroundColor = .black
        return view
    }()
    
    let progressView: UIProgressView = {
        var progress = UIProgressView()
        progress.progressViewStyle = .bar
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
   
    let uploadLink: String = ""
    var playerModel: ShowPlayerModel?
    
    init(playerModel: ShowPlayerModel) {
         super.init(nibName: nil, bundle: nil)
        self.playerModel = playerModel
        self.videoName.text = playerModel.songTitle
        self.viewsCount.text = "\(playerModel.viewsCount) просмотра"
        if !playerModel.playlistId.isEmpty {
            playerView.load(withPlaylistId: playerModel.playlistId)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGradient(colors: [.buttonGradientStart(), .buttonGradientEnd()])
        setPresenter()
        configureView()
        Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
    }

    fileprivate func setPresenter() {
        self.presenter = PlayerPresenter(view: self)
    }
    
    fileprivate func configureView() {
        self.view.layer.cornerRadius = 18
        self.view.clipsToBounds = true
        self.view.backgroundColor = .clear
        view.addSubview(containerView)
        
        
        containerView.addSubview(showViewButton)
        containerView.addSubview(progressView)
        containerView.addSubview(playerView)
        containerView.addSubview(videoName)
        containerView.addSubview(viewsCount)
        containerView.addSubview(buttonStackView)
        containerView.addSubview(volumeSlider)
        containerView.addGradient(colors: [UIColor.buttonGradientStart(), UIColor.buttonGradientEnd()])
        activateConstraints()
    }
    
    // MARK: -  Actions
    
   @objc func setProgress() {
       playerView.currentTime()
       self.playerView.currentTime { progress, _ in
           self.progressView.setProgress(progress / 261, animated: true)
       }
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
    // MARK: -  configure
    func configure(playerModel: ShowPlayerModel) {
        self.playerModel = playerModel
        
        self.videoName.text = playerModel.songTitle
        self.viewsCount.text = "\(playerModel.viewsCount) просмотра"
        
        playerView.load(withVideoId: playerModel.loadLink)
        playerView.load(withPlaylistId: playerModel.playlistId)
    }

        // MARK: -  Actions
    
    @objc func imageChanger() {
        playerIsVisible.toggle()
        var config = UIButton.Configuration.plain()
        config.image = playerIsVisible ? UIImage(named: "Close_Open"): UIImage(named: "Close_Open")?.rotated(byDegrees: 180) 
        
        showViewButton.configuration = config
    }
    
    @objc func changeVolume(_ sender: UISlider) {
        
    }
    // MARK: -  Constraints
    fileprivate func activateConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.height.equalTo(600)
        }
        
        showViewButton.snp.makeConstraints { make in
            make.top.equalTo(containerView)
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
// MARK: - PlayerPresenterProtocol
extension PlayerViewController: PlayerPresenterProtocol {
    func setPlayer() {
        ///
    }
}

//MARK: - UIGestureRecognizerDelegate
extension PlayerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

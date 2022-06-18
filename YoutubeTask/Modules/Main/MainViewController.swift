//
//  ViewController.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit
import SnapKit

protocol ClearPlayer: AnyObject {
    func sendToClear(clear: String)
}

class MainViewController: UIViewController {
    
    var model = [FirstCellModel]()
    
    var playerIsVisible: Bool = true
    
    weak var clearPlayer: ClearPlayer?
    
    var playerViewModel: ShowPlayerModel?
    
    let playerVC = PlayerViewController(playerModel: ShowPlayerModel())
    
    
    let mainTitle: UILabel = {
        var title = UILabel()
        title.text = "YouTube API"
        title.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        title.textColor = .white
        return title
    }()
    
    lazy var table: UITableView = {
        var table = UITableView(frame: .zero, style: .grouped)
        table.register(HeaderTableView.self, forHeaderFooterViewReuseIdentifier: HeaderTableView.identifier)
        table.register(FirstPlaylist.self, forCellReuseIdentifier: FirstPlaylist.identifier)
        table.register(SecondPlaylist.self, forCellReuseIdentifier: SecondPlaylist.identifier)
        table.dataSource = self
        table.backgroundColor = .black
        table.delegate = self
        table.isScrollEnabled = false
        return table
    }()
    
    lazy var showPlayerButton: ShowPlayerViewButton = {
        var button = ShowPlayerViewButton()
        //        button.backgroundColor = .systemPink
        //        button.showButton.addTarget(self, action: #selector(showPlayerAction(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubviews()
        addPlayerVC()
        
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(table)
        //        view.addSubview(showPlayerButton)
        
        activateConstraints()
    }
    func addPlayerVC() {
        addChild(playerVC)
        view.addSubview(playerVC.view)
        playerVC.didMove(toParent: self)
        playerVC.showViewButton.addTarget(self, action: #selector(changePlayerPostion(_:)), for: .touchUpInside)
        playerVC.view.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: self.view.frame.width, height: 600))
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(550)
            
        }
    }
    // MARK: -  Actions
    @objc fileprivate func changePlayerPostion(_ sender: UIButton) {
        playerIsVisible.toggle()
        UIView.animate(withDuration: 0.7) {
            self.playerVC.view.snp.updateConstraints { make in
                make.size.equalTo(CGSize(width: self.view.frame.width, height: 600))
                make.leading.trailing.equalTo(self.view)
                make.bottom.equalTo(self.view.snp.bottom).offset(self.playerIsVisible ? 0 : 550)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func showPlayer(_ sender: UIButton) {
        playerIsVisible.toggle()
        playerVC.playerIsVisible.toggle()
        UIView.animate(withDuration: 0.7) {
            self.playerVC.view.snp.updateConstraints { make in
                make.size.equalTo(CGSize(width: self.view.frame.width, height: 600))
                make.leading.trailing.equalTo(self.view)
                make.bottom.equalTo(self.view.snp.bottom).offset(0)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc fileprivate func hidePlayer() {
//        let v = UIScreen.
//        UIView.animate(withDuration: 0.7) {
//            player.view.snp.makeConstraints { make in
//                make.size.equalTo(CGSize(width: self.view.frame.width, height: 600))
//                make.leading.trailing.equalTo(view)
//                make.bottom.equalTo(view.snp.bottom).offset(0)
//
//            }
//        }
    }
    fileprivate func showPlayer(model: ShowPlayerModel) {
        playerIsVisible.toggle()

        let player = PlayerViewController(playerModel: model)
        addChild(player)
        view.addSubview(player.view)
        player.didMove(toParent: self)
        player.showViewButton.addTarget(self, action: #selector(hidePlayer), for: .touchUpInside)
        player.view.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: self.view.frame.width, height: 600))
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            
        }
        
        self.view.layoutIfNeeded()
    }
    
    
    
    fileprivate func activateConstraints() {
        //        playerVC.view.snp.makeConstraints { make in
        //            make.size.equalTo(CGSize(width: self.view.frame.width, height: 600))
        //            make.leading.trailing.equalTo(view)
        //            make.bottom.equalTo(view.snp.bottom).offset(550)
        //
        //        }
        //        showPlayerButton.snp.makeConstraints { make in
        //            make.leading.trailing.equalTo(view)
        //            make.bottom.equalTo(view.snp.bottom)
        //            make.height.equalTo(60)
        //        }
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.leading.equalTo(view).offset(20)
        }
        table.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        var cell: UITableViewCell?
        //
        //        if indexPath.row % 2 == 0 {
        //            cell = tableView.dequeueReusableCell(withIdentifier: FirstPlaylist.identifier, for: indexPath)
        //            cell?.backgroundColor = .black
        //        } else {
        //            cell = tableView.dequeueReusableCell(withIdentifier: SecondPlaylist.identifier, for: indexPath)
        //            cell?.backgroundColor = .black
        //        }
        //        cell?.selectionStyle = .none
        //        return cell!
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: FirstPlaylist.identifier, for: indexPath) as! FirstPlaylist
            cell.sendId = self
            cell.backgroundColor = .black
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SecondPlaylist.identifier, for: indexPath) as! SecondPlaylist
            cell.backgroundColor = .black
            cell.sendFromSecond = self
            return cell
        default: break
            //
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0  : return 200
        case 1  : return 300
        default : return 140
        }
    }
    
    /*      HEADER       */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableView.identifier) as? HeaderTableView else {
            return UITableViewHeaderFooterView()
        }
        header.sendUpload = self
        return header
    }
    
}

extension MainViewController: ShowButtonDelegate {
    func setShow(_ bool: Bool) {
        self.showPlayerButton.isHidden = bool
        print(bool)
    }
    
}
extension MainViewController: SendUploads {
    func sendUploads(playerModel: ShowPlayerModel) {
        self.playerViewModel = playerModel
        clearChildPlayer()
        showPlayer(model: playerModel)
        //            self.addPlayerVC()
        
        //        showPlayer(model: playerModel)
        //        let player = PlayerViewController(playerModel: playerModel)
        //        print(playerModel)
        //        self.navigationController?.present(player, animated: true)
    }
}
// MARK: - from first playlist
extension MainViewController: SendFromFirstPlaylist {
    func send(playerModel: ShowPlayerModel) {
        self.playerViewModel = playerModel
        
        //        let player = PlayerViewController(playerModel: playerModel)
        //        self.navigationController?.present(player, animated: true)
    }
}
// MARK: - from second playlist
extension MainViewController: SendFromSecondPlaylist {
    func sendSecond(playerModel: ShowPlayerModel) {
        self.playerViewModel = playerModel
        //        let player = PlayerViewController(playerModel: playerModel)
        //        self.navigationController?.present(player, animated: true)
        
    }
}

extension UIViewController {
    func clearChildPlayer() {
        if self.children.count > 0 {
            let vc: [UIViewController] = self.children
            vc.last?.willMove(toParent: nil)
            vc.last?.removeFromParent()
            vc.last?.view.removeFromSuperview()
        }
        
    }
    func addChildPlayer(model: ShowPlayerModel) {
        //        let player = PlayerViewController(playerModel: model)
        //        addChild(player)
        //
        //        self.view.addSubview(player.view)
        //        UIView.animate(withDuration: 0.7) {
        //
        //            player.view.snp.makeConstraints { make in
        //                make.size.equalTo(CGSize(width: self.view.frame.width, height: 600))
        //                make.leading.trailing.equalTo(self.view)
        //                make.bottom.equalTo(self.view.snp.bottom).offset(550)
        //            }
        //
        //            self.view.layoutIfNeeded()
        //        }
    }
}


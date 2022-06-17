//
//  ViewController.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var model = [FirstCellModel]()
    
    var playerIsVisible: Bool = false
    let playerVC = PlayerViewController(songTitle: " ", viewsCount: " ")
    
    
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
    
    let showPlayerButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemPink
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubviews()
        
//        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(showPlayer), userInfo: nil, repeats: false)
    }
    
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(table)
        view.addSubview(showPlayerButton)
//        addPlayerVC()
        
        
        activateConstraints()
    }
    
    func addPlayerVC() {
        addChild(playerVC)
        view.addSubview(playerVC.view)
        playerVC.didMove(toParent: self)
        playerVC.showViewButton.addTarget(self, action: #selector(changePlayerPostion(_:)), for: .touchUpInside)
        
    }
    fileprivate func activateConstraints() {
//        playerVC.view.snp.makeConstraints { make in
//            make.size.equalTo(CGSize(width: self.view.frame.width, height: 600))
//            make.leading.trailing.equalTo(view)
//            make.bottom.equalTo(view.snp.bottom).offset(550)
//
//        }
        showPlayerButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(60)
        }
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
    @objc
    fileprivate func changePlayerPostion(_ sender: UIButton) {
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
    @objc
    func showPlayer() {
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
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if indexPath.row % 2 == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: FirstPlaylist.identifier, for: indexPath)
            cell?.backgroundColor = .black
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: SecondPlaylist.identifier, for: indexPath)
            cell?.backgroundColor = .black
        }
        cell?.selectionStyle = .none
        return cell!
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
        return header
    }
    
}

extension MainViewController: SendVideoName {
    func testcall(_ name: String) {
        print(name)
        DispatchQueue.main.async {
            print(name)

        }
    }
}

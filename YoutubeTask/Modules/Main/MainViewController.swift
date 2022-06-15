//
//  ViewController.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        addSubviews()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(table)
        activateConstraints()
    }
    fileprivate func activateConstraints() {
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.leading.equalTo(view).offset(20)
        }
        table.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(30)
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








import SwiftUI

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewControlle = MainViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewControlle
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
}

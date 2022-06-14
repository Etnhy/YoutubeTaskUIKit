//
//  ViewController.swift
//  YoutubeTask
//
//  Created by Evhenii Mahlena on 14.06.2022.
//

import UIKit


class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
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

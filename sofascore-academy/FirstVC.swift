//
//  FirstVC.swift
//  sofascore-academy
//
//  Created by Five on 14.03.2022..
//

import UIKit

class FirstVC: UIViewController {

    let centralImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        configureImageView()
    }

    func configureImageView() {
        view.addSubview(centralImageView)
        centralImageView.translatesAutoresizingMaskIntoConstraints = false
        centralImageView.image = .checkmark

        NSLayoutConstraint.activate([
            centralImageView.widthAnchor.constraint(equalToConstant: 150),
            centralImageView.heightAnchor.constraint(equalToConstant: 150),
            centralImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centralImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

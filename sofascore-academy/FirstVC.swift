//
//  FirstVC.swift
//  sofascore-academy
//
//  Created by Five on 14.03.2022..
//

import UIKit

class FirstVC: UIViewController {

    let centralImageView = UIImageView()
    let topLeadingImageView = UIImageView()
    let topTrailingImageView = UIImageView()
    let bottomLeadingImageView = UIImageView()
    let bottomTrailingImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        configureViews()
    }

    func configureViews() {
        view.addSubview(centralImageView)
        centralImageView.translatesAutoresizingMaskIntoConstraints = false
        centralImageView.image = .checkmark

        NSLayoutConstraint.activate([
            centralImageView.widthAnchor.constraint(equalToConstant: 150),
            centralImageView.heightAnchor.constraint(equalToConstant: 150),
            centralImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centralImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])


        view.addSubview(topLeadingImageView)
        topLeadingImageView.translatesAutoresizingMaskIntoConstraints = false
        topLeadingImageView.image = .checkmark

        NSLayoutConstraint.activate([
            topLeadingImageView.widthAnchor.constraint(equalToConstant: 150),
            topLeadingImageView.heightAnchor.constraint(equalToConstant: 150),
            topLeadingImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topLeadingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])


        view.addSubview(topTrailingImageView)
        topTrailingImageView.translatesAutoresizingMaskIntoConstraints = false
        topTrailingImageView.image = .checkmark

        NSLayoutConstraint.activate([
            topTrailingImageView.widthAnchor.constraint(equalToConstant: 150),
            topTrailingImageView.heightAnchor.constraint(equalToConstant: 150),
            topTrailingImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topTrailingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])


        guard let tabBarHeight = self.tabBarController?.tabBar.frame.height else { return }


        view.addSubview(bottomLeadingImageView)
        bottomLeadingImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomLeadingImageView.image = .checkmark

        NSLayoutConstraint.activate([
            bottomLeadingImageView.widthAnchor.constraint(equalToConstant: 150),
            bottomLeadingImageView.heightAnchor.constraint(equalToConstant: 150),
            bottomLeadingImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight - 10),
            bottomLeadingImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])


        view.addSubview(bottomTrailingImageView)
        bottomTrailingImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomTrailingImageView.image = .checkmark

        NSLayoutConstraint.activate([
            bottomTrailingImageView.widthAnchor.constraint(equalToConstant: 150),
            bottomTrailingImageView.heightAnchor.constraint(equalToConstant: 150),
            bottomTrailingImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight - 10),
            bottomTrailingImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
}

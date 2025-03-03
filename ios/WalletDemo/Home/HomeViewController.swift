//
//  HomeViewController.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class HomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupSearchButton()
    }
    
    private func setupSearchButton() {
        let searchButton = UIBarButtonItem(
            image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(didTapSearch))
        navigationItem.rightBarButtonItem = searchButton
    }
                    
    @objc private func didTapSearch() {
        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .systemBackground
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

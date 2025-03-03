//
//  BaseViewController.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWalletButton()
    }
    
    private func setupWalletButton() {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.setTitle("Wallet 1 ", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        // todoo
        button.setImage(UIImage(named: "transaction"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .leading
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10)
        configuration.imagePadding = 5
        button.configuration = configuration
        button.addTarget(self, action: #selector(didTapWalletButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func didTapWalletButton() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Add new wallet", style: .default))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
        present(alert, animated: true)
    }
}

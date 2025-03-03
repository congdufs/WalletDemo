//
//  AssetCategoryContentCollectionViewCell.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class AssetCategoryContentCollectionViewCell: UICollectionViewCell {
    var onItemSelected: ((EventType) -> Void)?
    static let cellIdentifier = "AssetCategoryContentCollectionViewCell"
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = false
        return view
    }()
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "No balance yet. Buy or transfer crypto to get started!"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy Crypto", for: .normal)
        // todoo
        button.setImage(UIImage(named: "asset_normal"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    private let receiveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Receive Funds", for: .normal)
        // todoo
        button.setImage(UIImage(named: "asset_normal"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    private let connectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Connect Crypto.com Account", for: .normal)
        // todoo
        button.setImage(UIImage(named: "asset_normal"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(balanceLabel)
        containerView.addSubview(separateLine)
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: -10)
        configuration.imagePadding = 10
        buyButton.configuration = configuration
        receiveButton.configuration = configuration
        connectButton.configuration = configuration
        buyButton.addTarget(self, action: #selector(buttonDidTap(sender:)), for: .touchUpInside)
        receiveButton.addTarget(self, action: #selector(buttonDidTap(sender:)), for: .touchUpInside)
        connectButton.addTarget(self, action: #selector(buttonDidTap(sender:)), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        balanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        separateLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(balanceLabel.snp.bottom)
            make.height.equalTo(1.0 / UIScreen.main.scale)
        }
        
        let buttonStack = UIStackView(arrangedSubviews: [buyButton, receiveButton, connectButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = 0
        buttonStack.distribution = .fill
        
        containerView.addSubview(buttonStack)
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        buyButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        receiveButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        connectButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
        
    @objc func buttonDidTap(sender: UIButton) {
        if sender == buyButton {
            onItemSelected?(EventType.buy)
        } else if sender == receiveButton {
            onItemSelected?(EventType.receive)
        } else if sender == connectButton {
            onItemSelected?(EventType.connect)
        }
    }
}

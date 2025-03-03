//
//  AddNetworkTableViewCell.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class AddNetworkTableViewCell: UITableViewCell {
    static let cellIdentifier = "AddNetworkTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "transaction")
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 13)
        titleLabel.text = "Add Custom Network"
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
}

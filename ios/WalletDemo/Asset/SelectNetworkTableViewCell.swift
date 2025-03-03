//
//  SelectNetworkTableViewCell.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class SelectNetworkTableViewCell: UITableViewCell {
    static let cellIdentifier = "SelectNetworkTableViewCell"
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        // todoo
        imageView.image = UIImage(named: "unselected")
        //        imageView.layer.cornerRadius = 20
        //        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 13)
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        let separateline = UIView()
        separateline.backgroundColor = .gray
        contentView.addSubview(separateline)
        separateline.snp.makeConstraints { make in
            make.height.equalTo(1.0 / UIScreen.main.scale)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupData(_ data: NetworkItem) {
        titleLabel.text = data.currency.name
        iconImageView.image = UIImage(named: data.isSelected ? "selected" : "unselected")
    }
    
    func setSelected(_ isSelected: Bool) {
        iconImageView.image = UIImage(named: isSelected ? "selected" : "unselected")
    }
}

//
//  AssetEventCollectionViewCell.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class AssetEventCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AssetEventCollectionViewCell"
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .blue
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.centerX.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItem(data: EventItem) {
        iconImageView.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
    }

}

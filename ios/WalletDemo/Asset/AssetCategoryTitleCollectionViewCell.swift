//
//  AssetCategoryTitleCollectionViewCell.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class AssetCategoryTitleCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AssetCategoryTitleCollectionViewCell"
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.leading.trailing.equalToSuperview()
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItem(data: CategoryItem) {
        titleLabel.text = data.title
        titleLabel.textColor = data.isSelected ? .black : .gray
    }
}

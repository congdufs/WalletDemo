//
//  SearchBarView.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class SearchBarView: UIView {
    var onClicked: (() -> Void)?
    private let searchIcon = UIImageView(image: UIImage(named: "search"))
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Browse Web3"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 8
        clipsToBounds = true
        addSubview(searchIcon)
        addSubview(titleLabel)
        searchIcon.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.top.bottom.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        onClicked?()
    }
}

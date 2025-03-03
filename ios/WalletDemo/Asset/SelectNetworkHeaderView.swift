//
//  SelectNetworkHeaderView.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/2.
//

import UIKit

class SelectNetworkHeaderView: UITableViewHeaderFooterView {
    static let headerViewdentifier = "SelectNetworkHeaderView"
    private let titleLabel = UILabel()
        
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        var bgConfig = backgroundConfiguration ?? UIBackgroundConfiguration.listPlainHeaderFooter()
        bgConfig.backgroundColor = .white
        backgroundConfiguration = bgConfig
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textColor = .gray
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}

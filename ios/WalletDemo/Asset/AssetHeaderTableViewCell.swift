//
//  AssetHeaderTableViewCell.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class AssetHeaderTableViewCell: UITableViewCell {
    static let cellIdentifier = "AssetHeaderTableViewCell"
    private var moneyCount = 0.0
    private let networkButton = UIButton()
    private let moneyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 1
        label.text = "***"
        label.font = .boldSystemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    private let moneyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "money_invisible"), for: .normal)
        button.setImage(UIImage(named: "money_visible"), for: .selected)
        return button
    }()
    private let moneyIncreaseCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "*** . ***"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    var onNetworkButtonTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(networkButton)
        networkButton.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
        networkButton.setTitleColor(.gray, for: .normal)
        networkButton.titleLabel?.font = .systemFont(ofSize: 12)
        networkButton.setTitle("All Mainnets", for: .normal)
        networkButton.setImage(UIImage(named: "pull_down")?.withTintColor(.gray), for:.normal)
        networkButton.semanticContentAttribute = .forceRightToLeft
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -5)
        configuration.imagePadding = 5
        networkButton.configuration = configuration
        networkButton.addTarget(self, action: #selector(didTapNetworkButton), for: .touchUpInside)
        
        let moneyStackView = UIStackView()
        contentView.addSubview(moneyStackView)
        moneyStackView.axis = .horizontal
        moneyStackView.alignment = .center
        moneyStackView.spacing = 8
        moneyStackView.addArrangedSubview(moneyLabel)
        moneyStackView.addArrangedSubview(moneyButton)
        moneyStackView.snp.makeConstraints { make in
            make.top.equalTo(networkButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        moneyButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        moneyLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        moneyButton.addTarget(self, action: #selector(didTapMoneyButton), for: .touchUpInside)
        

        contentView.addSubview(moneyIncreaseCountLabel)
        moneyIncreaseCountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
            make.top.equalTo(moneyStackView.snp.bottom)
        }
    }

    @objc func didTapNetworkButton() {
        onNetworkButtonTapped?()
    }
    
    @objc func didTapMoneyButton() {
        moneyButton.isSelected = !moneyButton.isSelected
        // todoo $
        if moneyButton.isSelected {
            moneyLabel.text = "$ " + formatterStringFromDouble(moneyCount)
            moneyIncreaseCountLabel.text = "+$10 . +20%"
        } else {
            moneyLabel.text = "$ " + "***"
            moneyIncreaseCountLabel.text = "*** . ***"
        }
    }
    
    func configData(item: NetworkItem, sum: Double) {
        networkButton.setTitle(item.currency.name, for: .normal)
        // todoo $
        if moneyButton.isSelected {
            moneyLabel.text = item.currency.symbol + formatterStringFromDouble(sum)
//            moneyIncreaseCountLabel.text = "+$10 . +20%"
        }
        moneyCount = sum
    }
    
    private func formatterStringFromDouble(_ sum: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: sum)) ?? "0.00"
    }
}

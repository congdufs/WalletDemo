//
//  SelectNetworkViewController.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class SelectNetworkViewController: UIViewController {
    var onConfirmButtonTapped: (([NetworkItem], NetworkItem, Double) -> Void)?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Network"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close")?.withTintColor(.black), for: .normal)
        return button
    }()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = .systemBlue
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    var items = [NetworkItem]()
    private var currentSelectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(50)
        }
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(44)
        }
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(confirmButton.snp.top).offset(-10)
        }
        tableView.register(SelectNetworkTableViewCell.self, forCellReuseIdentifier: SelectNetworkTableViewCell.cellIdentifier)
        tableView.register(AddNetworkTableViewCell.self, forCellReuseIdentifier: AddNetworkTableViewCell.cellIdentifier)
        tableView.register(SelectNetworkHeaderView.self, forHeaderFooterViewReuseIdentifier: SelectNetworkHeaderView.headerViewdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
        
    @objc func didTapCloseButton() {
        dismiss(animated: true)
    }

    @objc func didTapConfirmButton() {
        var sum = 0.0
        for index in 0 ..< items.count {
            items[index].isSelected = false
            if currentSelectedIndex == 0 {
                sum += items[index].currency.amount
            }
        }
        if currentSelectedIndex != 0 {
            sum = items[currentSelectedIndex].currency.amount
        }
        items[currentSelectedIndex].isSelected = true
        onConfirmButtonTapped?(items, items[currentSelectedIndex], sum)
        dismiss(animated: true)
    }
}

extension SelectNetworkViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        switch (indexPath.section) {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: AddNetworkTableViewCell.cellIdentifier, for: indexPath)
        case 1:
            let selectingCell = tableView.dequeueReusableCell(withIdentifier: SelectNetworkTableViewCell.cellIdentifier, for: indexPath)
            if let selectingCell = selectingCell as? SelectNetworkTableViewCell, indexPath.row < items.count  {
                selectingCell.setupData(items[indexPath.row])
                if items[indexPath.row].isSelected {
                    currentSelectedIndex = indexPath.row
                }
            }
            cell = selectingCell
        default:
            cell = UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension SelectNetworkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: SelectNetworkHeaderView.headerViewdentifier) as? SelectNetworkHeaderView
        headerView?.setTitle(section == 0 ? "Custom Network" : "Mainnet")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let alert = UIAlertController(title: "Add Custom Network", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
            self.present(alert, animated: true)
        } else if indexPath.section == 1, indexPath.row != currentSelectedIndex {
            let currentIndexPath = IndexPath(row: currentSelectedIndex, section: 1)
            if let cell = tableView.cellForRow(at: currentIndexPath) as? SelectNetworkTableViewCell {
                cell.setSelected(false)
            }
            if let cell = tableView.cellForRow(at: indexPath) as? SelectNetworkTableViewCell {
                cell.setSelected(true)
                currentSelectedIndex = indexPath.row
            }
        }
    }
}

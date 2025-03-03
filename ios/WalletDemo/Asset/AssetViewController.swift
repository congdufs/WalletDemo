//
//  AssetViewController.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit
import SnapKit

class AssetViewController: BaseViewController {
    private var items = [NetworkItem]()
    private let tableView = UITableView()
    private let separateline = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupSettingsButton()
        setupBottomView()
        setupTableView()
        setupRefreshControl()
    }

    private func setupSettingsButton() {
        let settingsButton = UIBarButtonItem(
            image: UIImage(named: "setting")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    private func setupBottomView() {
        let searchView = SearchBarView()
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        searchView.onClicked = { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(title: "search", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
            self.present(alert, animated: true)
        }
        
        separateline.backgroundColor = .gray
        view.addSubview(separateline)
        separateline.snp.makeConstraints { make in
            make.height.equalTo(1.0 / UIScreen.main.scale)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(searchView.snp.top).offset(-10)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(AssetHeaderTableViewCell.self, forCellReuseIdentifier: AssetHeaderTableViewCell.cellIdentifier)
        tableView.register(AssetEventTableViewCell.self, forCellReuseIdentifier: AssetEventTableViewCell.cellIdentifier)
        tableView.register(AssetCategoryTableViewCell.self, forCellReuseIdentifier: AssetCategoryTableViewCell.cellIdentifier)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(separateline).offset(-1)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        // 模拟网络请求延迟
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.refreshControl?.endRefreshing()
            // update data...
        }
    }
    
    @objc private func didTapSettings() {
        let settingsVC = SettingViewController()
        settingsVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    private func updateData() {
        guard let url = Bundle.main.url(forResource: "Currency", withExtension: "json") else { return }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let currencies = try decoder.decode([Currency].self, from: data)
                DispatchQueue.main.async {
                    var items = [NetworkItem]()
                    for currency in currencies {
                        let item = NetworkItem(currency: currency, isSelected: false)
                        items.append(item)
                    }
                    self.items = items
                    let firstItem = NetworkItem(currency: Currency(name: "All Mainnets", symbol: "", id: 0, amount: 0), isSelected: true)
                    self.items.insert(firstItem, at: 0)
                    var sum = 0.0
                    for item in items {
                        sum += item.currency.amount
                    }
                    let indexPath = IndexPath(row: 0, section: 0)
                    if let cell = self.tableView.cellForRow(at: indexPath) as? AssetHeaderTableViewCell {
                        cell.configData(item: firstItem, sum: sum)
                    }
                }
            } catch {
                print("解析失败: \(error.localizedDescription)")
            }
        }
    }
}

extension AssetViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        switch (indexPath.row) {
        case 0:
            let headCell = tableView.dequeueReusableCell(withIdentifier: AssetHeaderTableViewCell.cellIdentifier, for: indexPath)
            if let headCell = headCell as? AssetHeaderTableViewCell {
                headCell.onNetworkButtonTapped = { [weak self] in
                    guard let self = self else { return }
                    let vc = SelectNetworkViewController()
                    vc.items = self.items
                    vc.onConfirmButtonTapped = { items, currentItem, sum in
                        self.items = items
                        headCell.configData(item: currentItem, sum: sum)
                    }
                    vc.modalPresentationStyle = .pageSheet
                    self.present(vc, animated: true)
                }
            }
            cell = headCell
        case 1:
            let eventCell = tableView.dequeueReusableCell(withIdentifier: AssetEventTableViewCell.cellIdentifier, for: indexPath)
            if let eventCell = eventCell as? AssetEventTableViewCell {
                eventCell.onItemSelected = { [weak self ] item in
                    guard let self = self else { return }
                    let alert = UIAlertController(title: item.title, message: nil, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
            cell = eventCell
        case 2:
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: AssetCategoryTableViewCell.cellIdentifier, for: indexPath)
            if let categoryCell = categoryCell as? AssetCategoryTableViewCell {
                categoryCell.onItemSelected = { [weak self ] type in
                    guard let self = self else { return }
                    let title: String
                    switch type {
                    case .buy: 
                        title = "buy"
                    case .receive:
                        title = "receive"
                    case .connect:
                        title = "connect"
                    }
                    let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
            cell = categoryCell
        default:
            cell = UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension AssetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.row) {
        case 0:
            return 130
        case 1:
            return 120
        case 2:
            return 280
        default:
            return CGFloat.leastNormalMagnitude
        }
    }
}

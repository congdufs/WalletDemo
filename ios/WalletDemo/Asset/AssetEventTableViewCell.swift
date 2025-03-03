//
//  AssetEventTableViewCell.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class AssetEventTableViewCell: UITableViewCell {
    static let cellIdentifier = "AssetEventTableViewCell"
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:80, height: 80)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(AssetEventCollectionViewCell.self, forCellWithReuseIdentifier: AssetEventCollectionViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var items: [EventItem] = [EventItem(id: "Buy", imageName: "transaction", title: "Buy"), EventItem(id: "Send", imageName: "transaction", title: "Send"), EventItem(id: "Receive", imageName: "transaction", title: "Receive"), EventItem(id: "Earn", imageName: "transaction", title: "Earn")]
    var onItemSelected: ((EventItem) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview()
        }
    }

}

extension AssetEventTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetEventCollectionViewCell.cellIdentifier, for: indexPath) as? AssetEventCollectionViewCell, indexPath.row < items.count else { return UICollectionViewCell() }
        let item = items[indexPath.row]
        cell.setupItem(data: item)
        return cell
    }
}

extension AssetEventTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < items.count else { return }
        let item = items[indexPath.row]
        onItemSelected?(item)
   }
}

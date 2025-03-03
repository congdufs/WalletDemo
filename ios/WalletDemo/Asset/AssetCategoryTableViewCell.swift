//
//  AssetCategoryTableViewCell.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit

class AssetCategoryTableViewCell: UITableViewCell {
    var onItemSelected: ((EventType) -> Void)?
    static let cellIdentifier = "AssetCategoryTableViewCell"
    lazy var titleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(AssetCategoryTitleCollectionViewCell.self, forCellWithReuseIdentifier: AssetCategoryTitleCollectionViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: 210)
        layout.minimumLineSpacing = 40
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(AssetCategoryContentCollectionViewCell.self, forCellWithReuseIdentifier: AssetCategoryContentCollectionViewCell.cellIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var items: [CategoryItem] = [CategoryItem(id: "Crypto", title: "Crypto", isSelected: true), CategoryItem(id: "Earn", title: "Earn",  isSelected: false), CategoryItem(id: "NFTs", title: "NFTs",  isSelected: false)]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleCollectionView)
        titleCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
            make.height.equalTo(30)
        }
        
        contentView.addSubview(contentCollectionView)
        contentCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleCollectionView.snp.bottom).offset(40)
            make.height.equalTo(210)
        }
        titleCollectionView.reloadData()
        contentCollectionView.reloadData()
    }
}

extension AssetCategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == titleCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetCategoryTitleCollectionViewCell.cellIdentifier, for: indexPath) as? AssetCategoryTitleCollectionViewCell, indexPath.row < items.count else { return UICollectionViewCell() }
            let item = items[indexPath.row]
            cell.setupItem(data: item)
            return cell
        } else if collectionView == contentCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetCategoryContentCollectionViewCell.cellIdentifier, for: indexPath) as? AssetCategoryContentCollectionViewCell, indexPath.row < items.count else { return UICollectionViewCell() }
            cell.onItemSelected = { [weak self ] type in
                self?.onItemSelected?(type)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension AssetCategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == titleCollectionView, indexPath.row < items.count, items[indexPath.row].isSelected == false else { return }
        for index in 0..<items.count {
            items[index].isSelected = false
        }
        items[indexPath.row].isSelected = true
        collectionView.reloadData()
        contentCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
   }
}


//extension AssetCategoryTableViewCell: UIScrollViewDelegate {
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        handlePageChange()
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            handlePageChange()
//        }
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        handlePageChange()
//    }
//}

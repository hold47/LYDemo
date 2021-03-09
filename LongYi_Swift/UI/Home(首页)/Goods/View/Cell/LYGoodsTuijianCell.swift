//
//  LYGoodsTuijianCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/2.
//

import UIKit

extension LYGoodsTuijianCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: LYGoodsTuijianItemCell.self, for: indexPath)
        cell.model = models?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionClosure?("为你推荐点击", indexPath.item)
    }
    
}

class LYGoodsTuijianCell: BaseTableViewCell {
    
    var actionClosure: ((String, Int) -> Void)?
    
    var models: [LYGoodsModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.backgroundColor = .clear
            collectionView.isScrollEnabled = false
            collectionView.showsVerticalScrollIndicator = false
            collectionView.register(nibWithCellClass: LYGoodsTuijianItemCell.self)
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .vertical
            let width = (Constant.screen_width - 4*Constant.margin) / 3
            layout.itemSize = CGSize(width: width, height: 220)
        }
    }
    
}

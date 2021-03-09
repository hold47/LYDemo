//
//  LYGoodsQuanCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/1.
//

import UIKit

extension LYGoodsQuanCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: LYGoodsQuanItemCell.self, for: indexPath)
        let m = model?.items?[indexPath.item]
        cell.title = m?.remarks
        return cell
    }
    
}

class LYGoodsQuanCell: BaseTableViewCell {
    
    var model: LYCouponModel? {
        didSet {
            collectionView.reloadData()
            manjianLogo.text = " \(model?.name ?? "") "
            if model?.is_get ?? 0 == 1 {
                quanButton.titleForNormal = "点击查看 >"
            } else {
                quanButton.titleForNormal = "点击领券 >"
            }
        }
    }
    
    @IBOutlet weak var quanButton: UIButton!
    @IBOutlet weak var manjianLogo: UILabel! {
        didSet {
            manjianLogo.cornerRadius = 2
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(nibWithCellClass: LYGoodsQuanItemCell.self)
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = CGSize(width: 80, height: 18)
        }
    }
    
}

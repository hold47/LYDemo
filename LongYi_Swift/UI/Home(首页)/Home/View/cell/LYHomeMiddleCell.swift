//
//  LYHomeMiddleCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/12.
//

import UIKit

extension LYHomeMiddleCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model?.goods?.count ?? 0 > 2 {
            return 2
        } else {
            return model?.goods?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let m = model?.goods?[indexPath.item]
        //  上层的cell
        if isTopCell {
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeMiddleItem1Cell.self, for: indexPath)
            cell.model = m
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeMiddleItem2Cell.self, for: indexPath)
            cell.model = m
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Constant.screen_width - Constant.margin*4)/4, height: collectionView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let m = model?.goods?[indexPath.item]
        actionClosure?("middle点击商品", m?.id ?? 0)
    }
    
}

class LYHomeMiddleCell: BaseCollectionViewCell {
    
    var model: LYADModel? {
        didSet {
            nameButton.titleForNormal = model?.name
            desLabel.text = " \(model?.view_more ?? "") "
            desLabel.textColor = UIColor(hexString: "\(model?.bgc ?? "")")
            desLabel.borderColor = UIColor(hexString: "\(model?.bgc ?? "")")
            
            collectionView.reloadData()
            contentView.backgroundColor = .clear
        }
    }
    
    var isTopCell = true
    var actionClosure: ((String, Int) -> Void)?
    
    @IBOutlet weak var nameButton: UIButton!
    @IBAction func clickNameButton(_ sender: Any) {
        actionClosure?("middle点击title", 0)
    }
    @IBOutlet weak var desLabel: UILabel! {
        didSet {
            desLabel.cornerRadius = 2
            desLabel.borderWidth = 0.3
            desLabel.borderColor = UIColor(hexString: "#8F2E00")
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(nibWithCellClass: LYHomeMiddleItem1Cell.self)
            collectionView.register(nibWithCellClass: LYHomeMiddleItem2Cell.self)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isScrollEnabled = false
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
    }

}

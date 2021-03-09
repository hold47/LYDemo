//
//  LYHomePpzqCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/13.
//

import UIKit
import CHIPageControl

extension LYHomePpzqCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: LYHomePpzqIconCell.self, for: indexPath)
        cell.model = model?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width/3, height: collectionView.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndex?(indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let progress = x/scrollView.width
        pageControl.progress = progress.double
    }
    
}

class LYHomePpzqCell: BaseCollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.isPagingEnabled = true
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(nibWithCellClass: LYHomePpzqIconCell.self)
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
    }
    var pageControl = CHIPageControlJaloro()
    var selectIndex: ((Int) -> Void)?
    
    var model: [LYBrandModel]? {
        didSet {
            guard let count = model?.count, count > 0 else { return }
            pageControl.numberOfPages = (count - 1)/6 + 1
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initSubviews()
    }
    
    override func initSubviews() {
        contentView.addSubview(pageControl)
        pageControl.elementWidth = 15
        pageControl.elementHeight = 3
        pageControl.radius = 1
        pageControl.tintColor = .lightGray
        pageControl.currentPageTintColor = Constant.mainColor
        pageControl.padding = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(0)
        }
    }

}

//
//  LYHomeLYZXCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/10.
//

import UIKit
import CHIPageControl

extension LYHomeLYZXCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: LYHomeLYZXIconCell.self, for: indexPath)
        cell.model = model?[indexPath.item]
        cell.buyButton.rx.tap.subscribe(onNext: { _ in
            self.actionClosure?("龙一周选购买", indexPath.item)
        }).disposed(by: cell.disposeBag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width/3, height: 155)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionClosure?("龙一周选点击", indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x - 50
        let count = x/scrollView.width + 1
        pageControl.set(progress: count.int, animated: true)
    }
    
}

class LYHomeLYZXCell: BaseCollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.isPagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(nibWithCellClass: LYHomeLYZXIconCell.self)
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
        }
    }
    var pageControl = CHIPageControlJaloro()
    var actionClosure: ((String, Int) -> Void)?
    var model: [LYGoodsModel]? {
        didSet {
            guard let count = model?.count, count > 0 else { return }
            pageControl.numberOfPages = (count - 1)/3 + 1
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

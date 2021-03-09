//
//  LYHomeMiaoshaCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2021/3/3.
//

import UIKit
import CHIPageControl

extension LYHomeMiaoshaCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: LYHomeMiaoshaItemCell.self, for: indexPath)
        let model = models?[indexPath.item]
        cell.model = model
        cell.buyButton.rx.tap.subscribe(onNext: { _ in
            self.actionClosure?("秒杀商品购买", indexPath.item)
        }).disposed(by: cell.disposeBag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width/3, height: 155)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionClosure?("秒杀商品点击", indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x - 50
        let count = x/scrollView.width + 1
        pageControl.set(progress: count.int, animated: true)
    }
}

class LYHomeMiaoshaCell: BaseCollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.isPagingEnabled = true
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(nibWithCellClass: LYHomeMiaoshaItemCell.self)
            collectionView.showsHorizontalScrollIndicator = false
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
    
    var models: [LYMiaoshaGoodsModel]? {
        didSet {
            guard let count = models?.count, count > 0 else { return }
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

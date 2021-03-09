//
//  LYYxbpView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/25.
//

import UIKit

extension LYYxbpView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return adModel?.banner_down?.first?.goods?.count ?? 0
        }
        
        if section == 1 {
            return tejiaModels?.count ?? 0
        }
        
        return moreModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withClass: LYYxbpYxttCell.self, for: indexPath)
            let model = adModel?.banner_down?.first?.goods?[indexPath.item]
            cell.model = model
            cell.buyButton.rx.tap.subscribe { [weak self] _ in
                self?.actionsClosure?("优选特推购物车", indexPath.item)
            }.disposed(by: cell.disposeBag)
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withClass: LYYxbpYxtjCell.self, for: indexPath)
            let model = tejiaModels?[indexPath.item]
            cell.model = model
            cell.buyButton.rx.tap.subscribe { [weak self] _ in
                self?.actionsClosure?("优选特价购物车", indexPath.item)
            }.disposed(by: cell.disposeBag)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withClass: LYYxbpMoreYxCell.self, for: indexPath)
        let model = moreModels?[indexPath.item]
        cell.model = model
        cell.cartButton.rx.tap.subscribe { [weak self] _ in
            self?.actionsClosure?("更多优选购物车", indexPath.item)
        }.disposed(by: cell.disposeBag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.section == 0 || indexPath.section == 1) {
            return CGSize(width: (Constant.screen_width - 2*Constant.margin)/3, height: 180)
        }
        return CGSize(width: Constant.screen_width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            actionsClosure?("优选特推点击", indexPath.item)
        }
        if indexPath.section == 1 {
            actionsClosure?("优选特价点击", indexPath.item)
        }
        if indexPath.section == 2 {
            actionsClosure?("更多优选点击", indexPath.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYYxbpBannerHeader.self, for: indexPath)
            header.dataSource = adModel?.banner
            header.actionClosure = { [weak self] name, index in
                self?.actionsClosure?(name, index)
            }
            return header
        }
        
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYYxbpNormalHeader.self, for: indexPath)
            header.logoLabel.backgroundColor = UIColor(hexString: "#FF8C00")
            header.titleLabel.text = "优选特价"
            header.moreButton.isHidden = false
            header.moreButton.rx.tap.subscribe { [weak self] _ in
                self?.actionsClosure?("优选特价查看更多", 0)
            }.disposed(by: header.disposeBag)
            return header
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYYxbpNormalHeader.self, for: indexPath)
        header.logoLabel.backgroundColor = UIColor(hexString: "#0CB95F")
        header.titleLabel.text = "更多优选"
        header.moreButton.isHidden = true
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: Constant.screen_width, height: 350)
        } else if section == 1 {
            if tejiaModels?.count ?? 0 > 0 {
                return CGSize(width: Constant.screen_width, height: 52)
            } else {
                return CGSize(width: Constant.screen_width, height: CGFloat.leastNormalMagnitude)
            }
        } else {
            return CGSize(width: Constant.screen_width, height: 52)
        }
    }
    
}

class LYYxbpView: UIView {
    
    var actionsClosure: ((String, Int) -> Void)?
    var collectionView: UICollectionView!
    var adModel: LYYxbpAdModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    var tejiaModels: [LYGoodsModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var moreModels: [LYGoodsModel]? {
        didSet {
            collectionView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initSubviews() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(nib: UINib(nibName: "\(LYYxbpBannerHeader.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LYYxbpBannerHeader.self)
        collectionView.register(nib: UINib(nibName: "\(LYYxbpNormalHeader.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LYYxbpNormalHeader.self)
        collectionView.register(nibWithCellClass: LYYxbpYxttCell.self)
        collectionView.register(nibWithCellClass: LYYxbpYxtjCell.self)
        collectionView.register(nibWithCellClass: LYYxbpMoreYxCell.self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

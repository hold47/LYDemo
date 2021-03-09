//
//  LYYaojuhuiView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/24.
//

import UIKit

extension LYYaojuhuiView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeYjhGoodsData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: LYHomeYjhCell.self, for: indexPath)
        cell.model = homeYjhGoodsData?[indexPath.item]
        cell.cartButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.actionsClosure?("药聚会购物车", indexPath.item)
        }).disposed(by: cell.disposeBag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Constant.screen_width - 2*Constant.margin) / 3, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYYaojuhuiHeader.self, for: indexPath)
        let titles = homeYjhNaviData?.compactMap { $0.name ?? ""}
        header.segmentDatasource.titles = titles ?? []
        header.selectIndex = { [weak self] index in
            self?.actionsClosure?("药聚会点击分类", index)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: Constant.screen_width, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
}

class LYYaojuhuiView: UIView {
    
    var actionsClosure: ((String, Int) -> Void)?
    
    var homeYjhNaviData: [LYYjhNaviModel]? {
        didSet {
            UIView.performWithoutAnimation {
                collectionView.reloadSections([0])
            }
        }
    }
    
    var homeYjhGoodsData: [LYGoodsModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var collectionView: UICollectionView!

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
        collectionView.backgroundColor = Constant.yjhColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(nib: UINib(nibName: "\(LYYaojuhuiHeader.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LYYaojuhuiHeader.self)
        collectionView.register(nibWithCellClass: LYHomeYjhCell.self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

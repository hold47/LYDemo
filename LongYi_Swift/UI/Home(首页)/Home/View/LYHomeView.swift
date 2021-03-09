//
//  LYHomeView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/4.
//

import UIKit

/*
 首页使用collectionview设置, section圆角通过header和footer手动设置, section 从上到下依次是:
 0       banner + menu
 1       抽奖(动态高度)
 2       秒杀(动态高度)
 3       龙一周选
 4       middle  中药精选/优选特推/当季热销/合资进口   取floor字段
 5       厂家特惠    取middle字段
 6       厂家特惠商品  取cjzz_goods字段
 6       药聚会
 7       品牌专区
 8       为你推荐
 */
enum LYHomeSectionType: Int, CaseIterable {
    case banner = 0
    case choujiang
    case miaosha
    case lyzx
    case middle
    case cjth
    case cjth_goods
    case yjh
    case ppzq
    case wntj
}

extension LYHomeView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return LYHomeSectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case LYHomeSectionType.banner.rawValue:
            return ADdata?.icon?.count ?? 0
        case LYHomeSectionType.choujiang.rawValue:
            return 1
        case LYHomeSectionType.miaosha.rawValue:
            return 1
        case LYHomeSectionType.lyzx.rawValue:
            return 1
        case LYHomeSectionType.middle.rawValue:
            return 4
        case LYHomeSectionType.cjth.rawValue:
            return ADdata?.middle?.count ?? 0
        case LYHomeSectionType.cjth_goods.rawValue:
            return 1
        case LYHomeSectionType.yjh.rawValue:
            return yjhGoodsData?.count ?? 0
        case LYHomeSectionType.ppzq.rawValue:
            return 1
        case LYHomeSectionType.wntj.rawValue:
            return wntjListData?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case LYHomeSectionType.banner.rawValue:
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeIconCell.self, for: indexPath)
            let model = ADdata?.icon?[indexPath.row]
            cell.model = model
            return cell
        case LYHomeSectionType.choujiang.rawValue:
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeChoujiangCell.self, for: indexPath)
            let model = ADdata?.icon_down?.first
            cell.model = model
            return cell
        case LYHomeSectionType.miaosha.rawValue:
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeMiaoshaCell.self, for: indexPath)
            let model = miaoshaData?.spike_notice?.data?.spikegoods
            cell.models = model
            cell.actionClosure = { (name, index) in
                self.actionsClosure?(name, index)
            }
            return cell
        case LYHomeSectionType.lyzx.rawValue:
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeLYZXCell.self, for: indexPath)
            let model = ADdata?.lyzx?.first?.goods
            cell.model = model
            cell.actionClosure = { (name, index) in
                self.actionsClosure?(name, index)
            }
            return cell
        case LYHomeSectionType.middle.rawValue:
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeMiddleCell.self, for: indexPath)
            cell.model = ADdata?.floor?[indexPath.item]
            if indexPath.item > 1 {
                cell.isTopCell = false
            } else {
                cell.isTopCell = true
            }
            cell.actionClosure = { name, index in
                self.actionsClosure?(name, index)
            }
            return cell
        case LYHomeSectionType.cjth.rawValue:
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeCjthCell.self, for: indexPath)
            let model = ADdata?.middle?[indexPath.item]
            cell.model = model
            return cell
        case LYHomeSectionType.cjth_goods.rawValue:
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeCjthGoodsCell.self, for: indexPath)
            let model = ADdata?.cjzz_goods?.first?.goods
            cell.model = model
            cell.actionClosure = { (name, index) in
                self.actionsClosure?(name, index)
            }
            return cell
        case LYHomeSectionType.yjh.rawValue:
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeYjhCell.self, for: indexPath)
            cell.model = yjhGoodsData?[indexPath.item]
            cell.cartButton.rx.tap.subscribe(onNext: { [weak self] _ in
                self?.actionsClosure?("药聚会购物车", indexPath.item)
            }).disposed(by: cell.disposeBag)
            return cell
        case LYHomeSectionType.ppzq.rawValue:
            let cell = collectionView.dequeueReusableCell(withClass: LYHomePpzqCell.self, for: indexPath)
            cell.model = brandListData
            cell.selectIndex = { index in
                self.actionsClosure?("品牌专区点击", index)
            }
            return cell
        case LYHomeSectionType.wntj.rawValue:
            let cell = collectionView.dequeueReusableCell(withClass: LYHomeWntjCell.self, for: indexPath)
            cell.model = wntjListData?[indexPath.item]
            cell.cartButton.rx.tap.subscribe(onNext: { [weak self] _ in
                self?.actionsClosure?("为你推荐购物车", indexPath.item)
            }).disposed(by: cell.disposeBag)
            
            if indexPath.item == (wntjListData?.count ?? 0) - 1 {
                cell.line.isHidden = true
            } else {
                cell.line.isHidden = false
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case LYHomeSectionType.banner.rawValue:
            actionsClosure?("首页分类", indexPath.item)
        case LYHomeSectionType.choujiang.rawValue:
            actionsClosure?("抽奖", 0)
        case LYHomeSectionType.cjth.rawValue:
            actionsClosure?("厂家特惠", indexPath.item)
        case LYHomeSectionType.yjh.rawValue:
            actionsClosure?("药聚会", indexPath.item)
        case LYHomeSectionType.wntj.rawValue:
            actionsClosure?("为你推荐点击", indexPath.item)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case LYHomeSectionType.banner.rawValue:
            return CGSize(width: Constant.screen_width/4, height: 75)
        case LYHomeSectionType.choujiang.rawValue:
            if ADdata?.icon_down?.count ?? 0 > 0 {
                return CGSize(width: Constant.screen_width, height: 102)
            } else {
                //  高度设置为0就会影响后面所有的section
                return CGSize(width: Constant.screen_width, height: 0.1)
            }
        case LYHomeSectionType.miaosha.rawValue:
            if miaoshaData?.spike_notice?.is_show ?? 0 == 1 {
                return CGSize(width: Constant.screen_width - 2*Constant.margin, height: 180)
            } else {
                return CGSize(width: Constant.screen_width - 2*Constant.margin, height: 0.1)
            }
        case LYHomeSectionType.lyzx.rawValue:
            return CGSize(width: Constant.screen_width - 2*Constant.margin, height: 180)
        case LYHomeSectionType.middle.rawValue:
            return CGSize(width: (Constant.screen_width - 2*Constant.margin) / 2, height: 130)
        case LYHomeSectionType.cjth.rawValue:
            return CGSize(width: (Constant.screen_width - 2*Constant.margin)/2, height: 92)
        case LYHomeSectionType.cjth_goods.rawValue:
            return CGSize(width: Constant.screen_width - 2*Constant.margin, height: 180)
            
        case LYHomeSectionType.yjh.rawValue:
            return CGSize(width: (Constant.screen_width - 2*Constant.margin) / 3, height: 250)
        case LYHomeSectionType.ppzq.rawValue:
            return CGSize(width: Constant.screen_width - 2*Constant.margin, height: 175)
        case LYHomeSectionType.wntj.rawValue:
            return CGSize(width: Constant.screen_width, height: 130)
        default:
            return CGSize(width: 150, height: 100)
        }
    }
    
    /// 不设置size就不会调用这个方法
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case LYHomeSectionType.banner.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeBannerView.self, for: indexPath)
                header.bannerData = ADdata?.banner
                header.selectIndex = { index in
                    self.actionsClosure?("banner", index)
                }
                header.scrollIndex = { index in
                    let model = self.ADdata?.banner?[index]
                    self.changeColorView.backgroundColor = UIColor(hexString: model?.bgc ?? "")
                }
                return header
            case LYHomeSectionType.miaosha.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeMiaoshaHeader.self, for: indexPath)
                header.moreButton.rx.tap.subscribe(onNext: { _ in
                    self.actionsClosure?("秒杀查看更多", 0)
                }).disposed(by: header.disposeBag)
                if miaoshaData != nil {
                    header.model = miaoshaData
                }
                
                return header
            case LYHomeSectionType.lyzx.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeNormalHeader.self, for: indexPath)
                header.bgColor = .white
                header.icon.isHidden = true
                header.iconLabel.isHidden = false
                header.iconLabel.text = "龙一周选"
                header.iconLabel.textColor = UIColor(hexString: "#333333")
                header.iconLabel.font = UIFont.boldSystemFont(ofSize: 16)
                header.titleLabel.isHidden = true
                header.moreButton.titleColorForNormal = UIColor(hexString: "#CCCCCC")
                header.moreButton.titleForNormal = "查看更多"
                header.moreButton.imageForNormal = UIImage(named: "arrow_right_gray")
                header.moreButton.rx.tap.subscribe(onNext: { _ in
                    self.actionsClosure?("龙一周选查看更多", 0)
                }).disposed(by: header.disposeBag)
                return header
            case LYHomeSectionType.middle.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeRoundHeader.self, for: indexPath)
                return header
            case LYHomeSectionType.cjth.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeNormalHeader.self, for: indexPath)
                header.bgColor = .white
                header.icon.isHidden = true
                header.iconLabel.isHidden = false
                header.iconLabel.text = "厂家特惠"
                header.iconLabel.textColor = UIColor(hexString: "#333333")
                header.iconLabel.font = UIFont.boldSystemFont(ofSize: 16)
                header.titleLabel.isHidden = true
                header.moreButton.titleColorForNormal = UIColor(hexString: "#CCCCCC")
                header.moreButton.titleForNormal = "查看更多"
                header.moreButton.imageForNormal = UIImage(named: "arrow_right_gray")
                header.moreButton.rx.tap.subscribe(onNext: { _ in
                    self.actionsClosure?("厂家特惠查看更多", 0)
                }).disposed(by: header.disposeBag)
                return header
            case LYHomeSectionType.yjh.rawValue:
                //                if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeYjhHeader.self, for: indexPath)
                let titles = yjhNaviData?.compactMap { $0.name ?? ""}
                header.segmentDatasource.titles = titles ?? []
                header.selectIndex = { [weak self] index in
                    self?.actionsClosure?("药聚会点击分类", index)
                }
                return header
            case LYHomeSectionType.ppzq.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeNormalHeader.self, for: indexPath)
                header.bgColor = .white
                header.iconLabel.text = "品牌专区"
                header.icon.isHidden = true
                header.iconLabel.isHidden = false
                header.titleLabel.isHidden = true
                header.moreButton.titleColorForNormal = UIColor(hexString: "#999999")
                header.moreButton.titleForNormal = "更多 >"
                header.moreButton.imageForNormal = UIImage(named: "arrow_right_gray")
                header.moreButton.rx.tap.subscribe(onNext: { _ in
                    self.actionsClosure?("品牌专区查看更多", 0)
                }).disposed(by: header.disposeBag)
                return header
            case LYHomeSectionType.wntj.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeWntjHeader.self, for: indexPath)
                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeNormalHeader.self, for: indexPath)
                header.bgColor = UIColor(hexString: "#FC2D47")!
                header.icon.image = UIImage(named: "home_yxbp")
                header.titleLabel.isHidden = false
                header.titleLabel.text = "好药配好礼 积分1:1"
                return header
            }
        } else {
            switch indexPath.section {
            
            case LYHomeSectionType.yjh.rawValue:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withClass: LYHomeYjhFooter.self, for: indexPath)
                footer.moreButton.rx.tap.subscribe(onNext: { [weak self] _ in
                    self?.actionsClosure?("药聚会查看全部", 0)
                }).disposed(by: footer.disposeBag)
                return footer
            default:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withClass: LYHomeNormalFooter.self, for: indexPath)
                return footer
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case LYHomeSectionType.banner.rawValue:
            return CGSize(width: Constant.screen_width, height: 160)
        case LYHomeSectionType.lyzx.rawValue,
             LYHomeSectionType.cjth.rawValue,
             LYHomeSectionType.ppzq.rawValue,
             LYHomeSectionType.wntj.rawValue:
            return CGSize(width: Constant.screen_width, height: 35)
        case LYHomeSectionType.miaosha.rawValue:
            if miaoshaData?.spike_notice?.is_show ?? 0 == 1 {
                return CGSize(width: Constant.screen_width, height: 35)
            } else {
                return CGSize(width: Constant.screen_width, height: 0.1)
            }
        case LYHomeSectionType.middle.rawValue:
            return CGSize(width: Constant.screen_width, height: 16)
        case LYHomeSectionType.yjh.rawValue:
            return CGSize(width: Constant.screen_width, height: 145)
        default:
            return CGSize(width: Constant.screen_width, height: 0.1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch section {
        case LYHomeSectionType.banner.rawValue,
             LYHomeSectionType.choujiang.rawValue,
             LYHomeSectionType.cjth.rawValue,
             LYHomeSectionType.wntj.rawValue:
            return CGSize(width: Constant.screen_width, height: 0.1)
        case LYHomeSectionType.yjh.rawValue:
            return CGSize(width: Constant.screen_width, height: 55)
        default:
            return CGSize(width: Constant.screen_width, height: 16 + Constant.margin)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case LYHomeSectionType.banner.rawValue:
            return UIEdgeInsets(top: Constant.margin, left: 0, bottom: Constant.margin, right: 0)
        case LYHomeSectionType.choujiang.rawValue:
            return UIEdgeInsets(top: 0, left: 0, bottom: Constant.margin, right: 0)
        case LYHomeSectionType.middle.rawValue,
             LYHomeSectionType.miaosha.rawValue,
             LYHomeSectionType.lyzx.rawValue,
             LYHomeSectionType.yjh.rawValue,
             LYHomeSectionType.ppzq.rawValue:
            return UIEdgeInsets(top: 0, left: Constant.margin, bottom: 0, right: Constant.margin)
        case LYHomeSectionType.cjth.rawValue:
            return UIEdgeInsets(top: 0, left: Constant.margin, bottom: 0, right: Constant.margin)
        default:
            return UIEdgeInsets.zero
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y > 0 && (isOpenSearchBar == true) {
            closeSearchBar()
        } else if y <= 0 && (isOpenSearchBar == false) {
            openSearchBar()
        }
    }
    
}

extension LYHomeView {
    
    func closeSearchBar() {
        UIView.animate(withDuration: 0.15) {
            self.naviView.searchView.snp.remakeConstraints { (make) in
                make.left.equalTo(Constant.margin)
                make.height.equalTo(30)
                make.right.equalTo(self.naviView.orderButton.snp.left).offset(-5)
            }
            self.naviView.layoutIfNeeded()
        } completion: { (_) in
            UIView.animate(withDuration: 0.15) {
                self.naviView.searchView.snp.remakeConstraints { (make) in
                    make.centerY.equalTo(self.naviView.orderButton)
                    make.height.equalTo(30)
                    make.right.equalTo(self.naviView.orderButton.snp.left).offset(-5)
                }
                self.naviView.layoutIfNeeded()
                
                self.naviView.snp.remakeConstraints { (make) in
                    make.top.equalTo(Constant.safeArea.top)
                    make.left.equalToSuperview()
                    make.width.equalTo(Constant.screen_width)
                    make.height.equalTo(55).priority(.high)
                }
                self.layoutIfNeeded()
            }
        }
        isOpenSearchBar = false
    }
    
    func openSearchBar() {
        UIView.animate(withDuration: 0.15) {
            self.naviView.searchView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.naviView.orderButton.snp.bottom).offset(21.5)
                make.left.equalTo(Constant.margin)
                make.height.equalTo(30)
                make.right.equalTo(self.naviView.orderButton.snp.left).offset(-5)
            }
            self.naviView.layoutIfNeeded()
        } completion: { (_) in
            UIView.animate(withDuration: 0.15) {
                self.naviView.searchView.snp.remakeConstraints { (make) in
                    make.left.equalTo(Constant.margin)
                    make.height.equalTo(30)
                    make.right.equalTo(-Constant.margin)
                }
                self.naviView.layoutIfNeeded()
                
                self.naviView.snp.remakeConstraints { (make) in
                    make.top.equalTo(Constant.safeArea.top)
                    make.left.equalToSuperview()
                    make.width.equalTo(Constant.screen_width)
                    make.height.equalTo(90)
                }
                self.layoutIfNeeded()
            }
        }
        isOpenSearchBar = true
    }
    
}

class LYHomeView: UIView {
    
    var actionsClosure: ((String, Int) -> Void)?
    
    let changeColorView = UIView(backgroundColor: Constant.mainColor)
    let naviView = LYHomeNaviView.loadFromNib(named: "\(LYHomeNaviView.self)") as! LYHomeNaviView
    var collectionView: UICollectionView!
    var isOpenSearchBar = true
    var ADdata: LYHomeADModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    var miaoshaData: LYMiaoshaModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    var yjhNaviData: [LYYjhNaviModel]? {
        didSet {
            UIView.performWithoutAnimation {
                collectionView.reloadSections([LYHomeSectionType.yjh.rawValue])
            }
        }
    }
    var yjhGoodsData: [LYGoodsModel]? {
        didSet {
            UIView.performWithoutAnimation {
                //  只刷新section会有复用bug
                collectionView.reloadData()
            }
        }
    }
    var brandListData: [LYBrandModel]? {
        didSet {
            UIView.performWithoutAnimation {
                collectionView.reloadSections([LYHomeSectionType.ppzq.rawValue])
            }
        }
    }
    var wntjListData: [LYGoodsModel]? {
        didSet {
            UIView.performWithoutAnimation {
                collectionView.reloadData()
            }
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
        
        addSubview(changeColorView)
        addSubview(naviView)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        insertSubview(collectionView, belowSubview: naviView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(nibWithCellClass: LYHomeIconCell.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeBannerView.self)
        collectionView.register(nib: UINib(nibName: "\(LYHomeNormalHeader.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeNormalHeader.self)
        collectionView.register(nib: UINib(nibName: "\(LYHomeMiaoshaHeader.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeMiaoshaHeader.self)
        collectionView.register(nib: UINib(nibName: "\(LYHomeYjhHeader.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeYjhHeader.self)
        collectionView.register(nib: UINib(nibName: "\(LYHomeWntjHeader.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeWntjHeader.self)
        collectionView.register(nib: UINib(nibName: "\(LYHomeYjhFooter.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withClass: LYHomeYjhFooter.self)
        collectionView.register(nib: UINib(nibName: "\(LYHomeNormalFooter.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withClass: LYHomeNormalFooter.self)
        collectionView.register(nib: UINib(nibName: "\(LYHomeRoundHeader.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LYHomeRoundHeader.self)
        collectionView.register(nibWithCellClass: LYHomeLYZXCell.self)
        collectionView.register(nibWithCellClass: LYHomeChoujiangCell.self)
        collectionView.register(nibWithCellClass: LYHomeMiaoshaCell.self)
        collectionView.register(nibWithCellClass: LYHomeMiddleCell.self)
        collectionView.register(nibWithCellClass: LYHomeCjthCell.self)
        collectionView.register(nibWithCellClass: LYHomeCjthGoodsCell.self)
        collectionView.register(nibWithCellClass: LYHomeYjhCell.self)
        collectionView.register(nibWithCellClass: LYHomePpzqCell.self)
        collectionView.register(nibWithCellClass: LYHomeWntjCell.self)
        collectionView.register(nibWithCellClass: LYHomeWntjCell.self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        changeColorView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150 + Constant.safeArea.top)
        }
        
        naviView.snp.makeConstraints { (make) in
            make.top.equalTo(Constant.safeArea.top)
            make.left.equalToSuperview()
            make.width.equalTo(Constant.screen_width)
            make.height.equalTo(90)
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(naviView.snp.bottom).offset(-50)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
}

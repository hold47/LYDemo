//
//  LYHomeHeaderView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/5.
//

import UIKit
import FSPagerView
import CHIPageControl

extension LYHomeBannerView: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bannerData?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: FSPagerViewCell.description(), at: index)
        let imageUrl = bannerData?[index].image
        cell.imageView?.setImage(imageUrl)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldSelectItemAt index: Int) -> Bool {
        return true
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return true
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        selectIndex?(index)
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        pageControl.progress = pagerView.scrollOffset.double
        scrollIndex?(pagerView.scrollOffset.int)
    }
    
}

//  MARK: - UI
class LYHomeBannerView: BaseCollectionReusableView {
    
    var banner: FSPagerView!
    var pageControl: CHIPageControlJaloro!
    var bannerData: [LYADModel]? {
        didSet {
            banner.reloadData()
            pageControl.numberOfPages = bannerData?.count ?? 0
        }
    }
    var selectIndex: ((Int) -> Void)?
    var scrollIndex: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initSubviews() {
        banner = FSPagerView()
        addSubview(banner)
        banner.dataSource = self
        banner.delegate = self
        banner.automaticSlidingInterval = 3
        banner.register(FSPagerViewCell.self, forCellWithReuseIdentifier: FSPagerViewCell.description())
//        banner.itemSize = FSPagerView.automaticSize
//        banner.transformer = FSPagerViewTransformer(type: .cubic)
        banner.cornerRadius = 8
        
        
        pageControl = CHIPageControlJaloro()
        banner.addSubview(pageControl)
        pageControl.elementWidth = 15
        pageControl.elementHeight = 3
        pageControl.radius = 1
        pageControl.tintColor = .lightGray
        pageControl.currentPageTintColor = .white
        pageControl.padding = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        banner.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(Constant.margin)
            make.right.equalToSuperview().offset(-Constant.margin)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-10)
        }
    }
    
}

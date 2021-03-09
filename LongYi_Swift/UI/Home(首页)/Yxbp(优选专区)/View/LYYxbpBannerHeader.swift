//
//  LYYxbpBannerHeader.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/25.
//

import UIKit
import FSPagerView

extension LYYxbpBannerHeader: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return dataSource?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: FSPagerViewCell.description(), at: index)
        let model = dataSource?[index]
        cell.imageView?.setImage(model?.image)
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
        actionClosure?("banner", index)
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        pageControl.progress = pagerView.scrollOffset.double
    }
    
}

class LYYxbpBannerHeader: BaseCollectionReusableView {
    
    var actionClosure: ((String, Int) -> Void)?
    var dataSource: [LYADModel]? {
        didSet {
            pageControl.numberOfPages = dataSource?.count ?? 0
            banner.reloadData()
        }
    }
    
    @IBOutlet weak var banner: FSPagerView! {
        didSet {
            banner.backgroundColor = .white
            banner.dataSource = self
            banner.delegate = self
            banner.automaticSlidingInterval = 3;
            banner.register(FSPagerViewCell.self, forCellWithReuseIdentifier: FSPagerViewCell.description())
        }
    }
    var pageControl: CHIPageControlJaloro!
    
    // TODO: - 这里无法使用rx.tap,原因不明
    @IBOutlet weak var roleButton: UIButton! {
        didSet {
            roleButton.layoutImage(type: .top, space: 5)
        }
    }
    
    @IBAction func clickRoleButton(_ sender: Any) {
        actionClosure?("兑换规则", 0)
    }
    
    @IBOutlet weak var quanButton: UIButton! {
        didSet {
            quanButton.layoutImage(type: .top, space: 5)
        }
    }
    
    @IBAction func clickQuanButton(_ sender: Any) {
        actionClosure?("优选优惠券", 0)
    }
    
    @IBOutlet weak var scoreButton: UIButton! {
        didSet {
            scoreButton.layoutImage(type: .top, space: 5)
        }
    }
    
    @IBAction func clickScoreButton(_ sender: Any) {
        actionClosure?("优选积分", 0)
    }
    
    @IBAction func clickSearchButton(_ sender: Any) {
        actionClosure?("搜索", 0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initSubviews()
    }
    
    override func initSubviews() {
        pageControl = CHIPageControlJaloro()
        addSubview(pageControl)
        pageControl.elementWidth = 15
        pageControl.elementHeight = 3
        pageControl.radius = 1
        pageControl.tintColor = .lightGray
        pageControl.currentPageTintColor = .white
        pageControl.padding = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(banner).offset(-5)
        }
    }
    
}


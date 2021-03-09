//
//  LYGoodsBannerCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/30.
//

import UIKit
import FSPagerView

extension LYGoodsBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return model?.goods_images?.count ?? 0
    }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: FSPagerViewCell.description(), at: index)
        let model = self.model?.goods_images?[index]
        cell.imageView?.setImage(model?.image_url)
        return cell
    }

    func pagerView(_ pagerView: FSPagerView, shouldSelectItemAt index: Int) -> Bool {
        return true
    }

    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }

    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        actionsClosure?("banner", index)
    }

    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        pageControl.progress = pagerView.scrollOffset.double
    }

}

class LYGoodsBannerCell: BaseTableViewCell {
    
    var actionsClosure: ((String, Int) -> Void)?
    var model: LYGoodsModel? {
        didSet {
            banner.reloadData()
            pageControl.numberOfPages = model?.goods_images?.count ?? 0
            nameLabel.text = model?.name
            desLabel.text = model?.ypgg
            priceLabel.text = "¥\(model?.price ?? "")"
            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 12))
            oldPriceLabel.text = "¥\(model?.base_price ?? "")"
            oldPriceLabel.attributedText = oldPriceLabel.text?.strikethrough
            ckLabel.text = "库存\(model?.number_label ?? "")"
            if model?.coupon_after_price?.count ?? 0 > 0 {
                quanSV.isHidden = false
                quanLabel.text = "  ≈¥\(model?.coupon_after_price ?? "")  "
            } else {
                quanSV.isHidden = true
            }
            if model?.xg_number ?? 0 > 0 {
                xiangouLabel.isHidden = false
                xiangouLabel.text = model?.xg_number_desc
            } else {
                xiangouLabel.isHidden = true
            }
            if model?.is_youx ?? 0 == 1 {
                youxLogoLabel.isHidden = false
            } else {
                youxLogoLabel.isHidden = true
            }
            if model?.is_tj ?? 0 == 1 {
                tejiaSV.isHidden = false
                tejiaIcon.isHidden = false
                if model?.activity_name?.count ?? 0 > 0 {
                    activityButton.titleForNormal = "\(model?.activity_name ?? "")>>>"
                    activityButton.isEnabled = true
                } else {
                    activityButton.titleForNormal = ""
                    activityButton.isEnabled = false
                }
            } else {
                tejiaSV.isHidden = true
                tejiaIcon.isHidden = true
            }
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
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var tejiaIcon: UIImageView!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var tejiaSV: UIStackView! {
        didSet {
            tejiaSV.isHidden = true
        }
    }
    @IBOutlet weak var miaoshaSV: UIStackView! {
        didSet {
            miaoshaSV.isHidden = true
        }
    }
    @IBOutlet weak var quanSV: UIStackView!
    @IBOutlet weak var quanLogoLabel: UILabel! {
        didSet {
            quanLogoLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var quanLabel: UILabel! {
        didSet {
            quanLabel.borderColor = Constant.mainColor
            quanLabel.borderWidth = 0.5
            quanLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var youxLogoLabel: UILabel! {
        didSet {
            youxLogoLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var xiangouLabel: UILabel!
    @IBOutlet weak var ckLabel: UILabel!
    
    
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
        pageControl.currentPageTintColor = Constant.mainColor
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

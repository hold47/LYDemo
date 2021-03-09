//
//  LYYxbpMoreYxCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/25.
//

import UIKit

class LYYxbpMoreYxCell: BaseCollectionViewCell {
    
    var model: LYGoodsModel? {
        didSet {
            if model?.tags?.count ?? 0 > 0 {
                let tag = model?.tags?.first
                stateLabel.text = tag?.name
                stateLabel.isHidden = false
            } else {
                stateLabel.isHidden = true
            }
            
            icon.setImage(model?.goods_image)
            if model?.is_youx ?? 0 == 1 {
                youxLabel.isHidden = false
            } else if model?.is_youx ?? 0 == 0 {
                youxLabel.isHidden = true
            }
            nameLabel.text = model?.name
            companyLabel.text = model?.sccj
            desLabel.text = model?.ypgg
            priceLabel.text = "¥\(model?.price ?? "")"
            oldPriceLabel.text = "¥\(model?.base_price ?? "")"
            oldPriceLabel.attributedText = oldPriceLabel.text?.strikethrough
            if model?.coupon_after_price?.count ?? 0 > 0 {
                quanLogoLabel.isHidden = false
                quanTitleLabel.isHidden = false
                quanTitleLabel.text = "  ≈¥\(model?.coupon_after_price ?? "")  "
            } else {
                quanLogoLabel.isHidden = true
                quanTitleLabel.isHidden = true
            }
            if (model?.is_buy ?? 0 == 1) && (model?.number ?? 0 > 0) {
                cartButton.isEnabled = true
            } else {
                cartButton.isEnabled = false
            }
        }
    }
    
    @IBOutlet weak var stateLabel: UILabel! {
        didSet {
            stateLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var youxLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var quanLogoLabel: UILabel! {
        didSet {
            quanLogoLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var quanTitleLabel: UILabel! {
        didSet {
            quanTitleLabel.cornerRadius = 2
            quanTitleLabel.borderColor = Constant.mainColor
            quanTitleLabel.borderWidth = 0.5
        }
    }
    
    @IBOutlet weak var cartButton: UIButton! {
        didSet {
            cartButton.imageForNormal = UIImage(named: "home_cart")
            cartButton.imageForDisabled = UIImage(named: "home_cart_disable")
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

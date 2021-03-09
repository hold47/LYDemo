//
//  LYHomeWntjCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/13.
//

import UIKit

class LYHomeWntjCell: BaseCollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var yxLabel: UILabel! {
        didSet {
            yxLabel.borderColor = UIColor(hexString: "#0CB95F")
            yxLabel.borderWidth = 0.5
            yxLabel.cornerRadius = 2
        }
    }
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
    @IBOutlet weak var quanPriceLabel: UILabel! {
        didSet {
            quanPriceLabel.cornerRadius = 2
            quanPriceLabel.borderWidth = 0.5
            quanPriceLabel.borderColor = UIColor(hexString: "#0CB95F")
        }
    }
    @IBOutlet weak var cartButton: UIButton! {
        didSet {
            cartButton.imageForNormal = UIImage(named: "home_cart")
            cartButton.imageForDisabled = UIImage(named: "home_cart_disable")
        }
    }
    @IBOutlet weak var line: UILabel!
    
    var model: LYGoodsModel? {
        didSet {
            icon.setImage(model?.goods_image)
            yxLabel.isHidden = model?.is_youx == 1 ? false : true
            nameLabel.text = model?.name
            companyLabel.text = model?.sccj
            desLabel.text = model?.ypgg
            priceLabel.text = "¥\(model?.price ?? "")"
            oldPriceLabel.text = "¥\(model?.base_price ?? "")"
            oldPriceLabel.attributedText = oldPriceLabel.text?.strikethrough
            
            if model?.coupon_after_price?.isEmpty ?? true {
                quanPriceLabel.isHidden = true
                quanLogoLabel.isHidden = true
            } else {
                quanPriceLabel.isHidden = false
                quanLogoLabel.isHidden = false
                quanPriceLabel.text = "≈¥\(model?.coupon_after_price ?? "")"+"  "
            }
            
            if model?.is_buy == 1 {
                cartButton.isEnabled = true
            } else {
                cartButton.isEnabled = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

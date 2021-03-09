//
//  LYHomeYjhCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/16.
//

import UIKit

class LYHomeYjhCell: BaseCollectionViewCell {
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.cornerRadius = 5
            bgView.backgroundColor = .white
        }
    }
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton! {
        didSet {
            cartButton.cornerRadius = 5
        }
    }
    
    var model: LYGoodsModel? {
        didSet {
            icon.setImage(model?.goods_image)
            nameLabel.text = model?.name
            companyLabel.text = model?.sccj
            desLabel.text = model?.ypgg
            priceLabel.text = "¥\(model?.price ?? "")"
            oldPriceLabel.text = "¥\(model?.base_price ?? "")"
            oldPriceLabel.attributedText = oldPriceLabel.text?.strikethrough
            
            if model?.is_buy ?? 0 == 1 {
                cartButton.isEnabled = true
                cartButton.titleForNormal = "加入购物车"
                cartButton.backgroundColor = Constant.yjhColor
            } else {
                cartButton.isEnabled = false
                cartButton.titleForNormal = model?.buy_button_label
                cartButton.backgroundColor = UIColor(hexString: "#CDCDCD")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Constant.yjhColor
    }

}

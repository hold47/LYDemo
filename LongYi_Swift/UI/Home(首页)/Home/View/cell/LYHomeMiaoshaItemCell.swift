//
//  LYHomeMiaoshaItemCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2021/3/3.
//

import UIKit

class LYHomeMiaoshaItemCell: BaseCollectionViewCell {
    
    var model: LYMiaoshaGoodsModel? {
        didSet {
            icon.setImage(model?.image)
            nameLabel.text = model?.name
            ggLabel.text = model?.ypgg
            priceLabel.text = "¥\(model?.price ?? "")"
            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 6))
            oldPriceLabel.text = "¥\(model?.ori_price ?? "")"
            oldPriceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 6))
            oldPriceLabel.attributedText = oldPriceLabel.text?.strikethrough
        }
    }
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.borderColor = UIColor(hexString: "#F5F5F5")
            bgView.borderWidth = 0.5
            bgView.backgroundColor = .white
            bgView.cornerRadius = 4
        }
    }
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ggLabel: UILabel!
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.cornerRadius = 4
        }
    }
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton! {
        didSet {
            buyButton.cornerRadius = 2
        }
    }

}

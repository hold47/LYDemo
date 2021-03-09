//
//  LYHomeLYZXIconCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/10.
//

import UIKit

class LYHomeLYZXIconCell: BaseCollectionViewCell {
    
    var model: LYGoodsModel? {
        didSet {
            icon.setImage(model?.goods_image)
            nameLabel.text = model?.name
            ggLabel.text = model?.ypgg
            priceLabel.text = "¥\(model?.price ?? "")"
            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 6))
            oldPriceLabel.text = "¥\(model?.base_price ?? "")"
            oldPriceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 6))
            oldPriceLabel.attributedText = oldPriceLabel.text?.strikethrough
        }
    }

    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.cornerRadius = 4
            bgView.borderColor = UIColor(hexString: "#FF8200")
            bgView.borderWidth = 0.5
            bgView.backgroundColor = .white
        }
    }
    @IBOutlet weak var icon: UIImageView! {
        didSet {
            icon.cornerRadius = 5
        }
    }
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

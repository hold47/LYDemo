//
//  LYHomeMiddleItem1Cell.swift
//  LongYi_Swift
//
//  Created by Hold on 2021/3/4.
//

import UIKit

class LYHomeMiddleItem1Cell: BaseCollectionViewCell {
    
    var model: LYGoodsModel? {
        didSet {
            icon.setImage(model?.goods_image)
            nameLabel.text = model?.name
            desLabel.text = model?.ypgg
            priceLabel.text = "¥\(model?.price ?? "")"
            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 8))
            oldPriceLabel.text = "¥\(model?.base_price ?? "")"
            oldPriceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 8))
            oldPriceLabel.attributedText = oldPriceLabel.text?.strikethrough
        }
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    
}

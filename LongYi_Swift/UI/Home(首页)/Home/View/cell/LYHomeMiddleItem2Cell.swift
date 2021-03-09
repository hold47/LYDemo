//
//  LYHomeMiddleItem2Cell.swift
//  LongYi_Swift
//
//  Created by Hold on 2021/3/4.
//

import UIKit

class LYHomeMiddleItem2Cell: BaseCollectionViewCell {
    
    var model: LYGoodsModel? {
        didSet {
            icon.setImage(model?.goods_image)
            nameLabel.text = model?.name
            desLabel.text = model?.ypgg
            priceLabel.text = "¥\(model?.price ?? "")"
            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 8))
        }
    }

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.cornerRadius = 2
            priceLabel.borderColor = UIColor(hexString: "#FF0000")
            priceLabel.borderWidth = 0.5
        }
    }
    
}

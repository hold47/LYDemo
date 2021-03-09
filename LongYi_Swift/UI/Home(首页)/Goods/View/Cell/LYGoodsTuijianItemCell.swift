//
//  LYGoodsTuijianItemCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/2.
//

import UIKit

class LYGoodsTuijianItemCell: BaseCollectionViewCell {
    
    var model: LYGoodsModel? {
        didSet {
            icon.setImage(model?.goods_image)
            nameLabel.text = model?.name
            companyLabel.text = model?.sccj
            desLabel.text = model?.ypgg
            priceLabel.text = "¥\(model?.price ?? "")"
            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 12))
            oldPriceLabel.text = "¥\(model?.base_price ?? "")"
            oldPriceLabel.attributedText = oldPriceLabel.text?.strikethrough
        }
    }
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.cornerRadius = 5
        }
    }
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//
//  LYYxbpYxtjCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/25.
//

import UIKit

class LYYxbpYxtjCell: BaseCollectionViewCell {
    
    var model: LYGoodsModel? {
        didSet {
            icon.setImage(model?.goods_image)
            nameLabel.text = model?.name
            companyLabel.text = model?.sccj
            cpggLabel.text = model?.ypgg
            priceLabel.text = "¥\(model?.price ?? "")"
            oldPriceLabel.text = "¥\(model?.base_price ?? "")"
            oldPriceLabel.attributedText = oldPriceLabel.text?.strikethrough
        }
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var cpggLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton! {
        didSet {
            buyButton.cornerRadius = 2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

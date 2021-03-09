//
//  LYOrderDetailGoodsListCell.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/8.
//

import UIKit

class LYOrderDetailGoodsListCell: BaseTableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var ypggLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var model: LYOrderGoodModel? {
        didSet {
            guard let order = model else { return }
            guard let good = order.goods else { return }
            icon.setImage(good.goods_image)
            nameLabel.text = good.name
            companyLabel.text = good.sccj
            ypggLabel.text = good.ypgg
            priceLabel.text = "¥ \(order.price ?? "")"
            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 14))
            countLabel.text = "X\(order.number ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

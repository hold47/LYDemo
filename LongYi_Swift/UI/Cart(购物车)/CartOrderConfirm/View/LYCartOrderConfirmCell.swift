//
//  LYCartOrderConfirmCell.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/13.
//

import UIKit

class LYCartOrderConfirmCell: BaseTableViewCell {
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.backgroundColor = .white
            bgView.cornerRadius = 8
        }
    }
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var ypggLabel: UILabel!
    @IBOutlet weak var yxqLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
//    var model: LYCartOrderModel? {
//        didSet {
//            icon.setImage(model?.goods?.goods_image)
//            nameLabel.text = model?.goods?.name
//            companyLabel.text = model?.goods?.sccj
//            ypggLabel.text = "规格: \(model?.goods?.ypgg ?? "")"
//            yxqLabel.text = "效期: \(model?.goods?.yxq ?? "")"
//            priceLabel.text = "¥ \(model?.goods?.price ?? "")"
//            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 14))
//            countLabel.text = "X\(model?.number ?? 0)"
//        }
//    }
    
}

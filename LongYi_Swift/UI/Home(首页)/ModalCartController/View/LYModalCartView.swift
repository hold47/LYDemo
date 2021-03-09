//
//  LYModalCartView.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/9.
//

import UIKit

class LYModalCartView: UIView {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var jhzkjLabel: UILabel! {
        didSet {
            jhzkjLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var jhPriceLabel: UILabel! {
        didSet {
            jhPriceLabel.borderColor = Constant.mainColor
            jhPriceLabel.borderWidth = 0.5
            jhPriceLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var spggLabel: UILabel!
    @IBOutlet weak var pzwhLabel: UILabel!
    @IBOutlet weak var yxqLabel: UILabel!
    @IBOutlet weak var quanSV: UIStackView!
    @IBOutlet weak var xgLogoLabel: UILabel!
    @IBOutlet weak var xgLabel: UILabel!
    @IBOutlet weak var zbzLabel: UILabel!
    @IBOutlet weak var jzlLabel: UILabel!
    @IBOutlet weak var kcLabel: UILabel!
    @IBOutlet weak var addMinusView: LYAddMinusView! {
        didSet {
            addMinusView.backgroundColor = .white
            addMinusView.borderColor = UIColor(hexString: "#DCDCDC")
            addMinusView.borderWidth = 0.5
            addMinusView.cornerRadius = 15
            addMinusView.textField.backgroundColor = .white
        }
    }
    @IBOutlet weak var confirmButton: UIButton! {
        didSet {
            confirmButton.cornerRadius = confirmButton.height / 2
        }
    }
    
    var model: LYGoodsModel? {
        didSet {
            guard let model = model else { return }
            icon.setImage(model.goods_image)
            nameLabel.text = model.name
            priceLabel.text = "¥\(model.price ?? "")"
            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 12))
            oldPriceLabel.text = "¥\(model.market_price ?? "")"
            oldPriceLabel.attributedText = oldPriceLabel.text?.strikethrough
            companyLabel.text = model.sccj
            spggLabel.text = model.ypgg
            pzwhLabel.text = model.pzwh
            yxqLabel.text = model.yxq
            zbzLabel.text = model.zbz?.string
            jzlLabel.text = model.jzl?.string
//            kcLabel.text = model.number_label
            
            //  限购
            if (model.xg_number ?? 0) == 0 {
                xgLogoLabel.isHidden = true
                xgLabel.isHidden = true
            } else {
                xgLogoLabel.isHidden = true
                xgLabel.isHidden = true
                xgLabel.text = model.xg_number_desc
            }
            
            //  卷后折扣价
            if (model.coupon_after_price?.count ?? 0) > 0 {
                quanSV.isHidden = false
                jhPriceLabel.text = " ≈¥\(model.coupon_after_price ?? "") "
            } else {
                quanSV.isHidden = true
            }
            
            addMinusView.baseCount = model.zbz ?? 1
            addMinusView.textField.text = model.zbz?.string
        }
    }

}

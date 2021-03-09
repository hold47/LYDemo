//
//  LYCartCell.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/11.
//

import UIKit

class LYCartCell: BaseTableViewCell {
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.cornerRadius = 8
        }
    }
    @IBOutlet weak var selectButton: UIButton! {
        didSet {
            selectButton.imageForNormal = UIImage(named: "button_unselect")
            selectButton.imageForSelected = UIImage(named: "button_select")
        }
    }
    @IBOutlet weak var icon: UIImageView! {
        didSet {
            icon.cornerRadius = 4
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var jzlLabel: UILabel!
    @IBOutlet weak var zbzLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addMinusView: LYAddMinusView!
    @IBOutlet weak var deleteButton: UIButton!
    
//    var model: LYCartOrderModel? {
//        didSet {
//            selectButton.isSelected = model?.isSelect ?? false
//            icon.setImage(model?.goods?.goods_image)
//            nameLabel.text = model?.goods?.name
//            companyLabel.text = model?.goods?.sccj
//            jzlLabel.text = "件装量: \(model?.goods?.jzl?.string ?? "")"
//            zbzLabel.text = "中包装: \(model?.goods?.zbz?.string ?? "")"
//            priceLabel.text = "¥\(model?.price ?? "")"
//            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 14))
//            addMinusView.baseCount = model?.goods?.zbz ?? 1
//            addMinusView.textField.text = model?.number?.string
//        }
//    }
    
}

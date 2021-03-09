//
//  LYOrderCell.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/6.
//

import UIKit

class LYOrderCell: BaseTableViewCell {
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.cornerRadius = 8
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton! {
        didSet {
            detailButton.isUserInteractionEnabled = false
            detailButton.cornerRadius = 13
        }
    }
    
    var model: LYOrderModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = "单位名称: \(model.user?.company ?? "")"
            orderLabel.text = model.order_sn
            timeLabel.text = model.created_at
            priceLabel.text = "¥ \(model.goods_amount ?? "")"
            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 14))
            stateLabel.text = model.order_status_label
        }
    }
    
}

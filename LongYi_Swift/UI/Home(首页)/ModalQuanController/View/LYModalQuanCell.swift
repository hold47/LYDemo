//
//  LYModalQuanCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/3.
//

import UIKit

class LYModalQuanCell: BaseTableViewCell {
    
    var model: LYQuanItemModel? {
        didSet {
            nameLabel.text = model?.name
            remarksLabel.text = model?.remarks
            priceLabel.text = "¥\(model?.money ?? "")"
            priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 14))
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remarksLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initSubviews()
    }
    
}

//
//  LYGoodsQuanItemCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/1.
//

import UIKit

class LYGoodsQuanItemCell: BaseCollectionViewCell {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initSubviews()
    }
    
    override func initSubviews() {
        contentView.cornerRadius = 2
        contentView.borderWidth = 0.5
        contentView.borderColor = UIColor(hexString: "#FF2828")
    }

}

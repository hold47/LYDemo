//
//  LYGoodsGuigeCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/30.
//

import UIKit

class LYGoodsGuigeCell: BaseTableViewCell {
    
    var model: LYGoodsModel? {
        didSet {
            sccjLabel.text = model?.sccj
            xiaoqiLabel.text = model?.yxq
            zbzLabel.text = model?.zbz?.string
            jzlLabel.text = model?.jzl?.string
            pzwhLabel.text = model?.pzwh
            
            if model?.is_xq ?? 0 == 1 {
                xiaoqiLabel.textColor = .red
                xiaoqiLogo.textColor = .red
            } else {
                xiaoqiLabel.textColor = UIColor(hexString: "#333333")
                xiaoqiLogo.textColor = UIColor(hexString: "#999999")
            }
        }
    }
    
    @IBOutlet weak var sccjLabel: UILabel!
    @IBOutlet weak var xiaoqiLabel: UILabel!
    @IBOutlet weak var xiaoqiLogo: UILabel!
    @IBOutlet weak var zbzLabel: UILabel!
    @IBOutlet weak var jzlLabel: UILabel!
    @IBOutlet weak var pzwhLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

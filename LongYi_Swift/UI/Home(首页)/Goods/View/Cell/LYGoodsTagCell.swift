//
//  LYGoodsTagCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/1.
//

import UIKit

class LYGoodsTagCell: BaseTableViewCell {
    
    var model: LYGoodsTagModel? {
        didSet {
            tagLabel.text = "\(model?.name ?? "")"
            if model?.name == "赠" {
                tagLabel.backgroundColor = UIColor(hexString: "#1D88CA")
            } else {
                tagLabel.backgroundColor = UIColor(hexString: "#FF7E28")
            }
            contentLabel.text = model?.describe
        }
    }
    
    @IBOutlet weak var tagLabel: UILabel! {
        didSet {
            tagLabel.cornerRadius = 2
        }
    }
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

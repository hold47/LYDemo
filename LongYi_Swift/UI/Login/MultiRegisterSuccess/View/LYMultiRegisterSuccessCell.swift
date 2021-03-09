//
//  LYMultiRegisterSuccessCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/2.
//

import UIKit

class LYMultiRegisterSuccessCell: BaseTableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    var model: LYAccountShopModel? {
        didSet {
            nameLabel.text = model?.company
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

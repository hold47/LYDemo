//
//  LYMultiRegisterInfoCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/1.
//

import UIKit

class LYMultiRegisterInfoCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: LYAccountShopModel? {
        didSet {
            titleLabel.text = model?.company
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

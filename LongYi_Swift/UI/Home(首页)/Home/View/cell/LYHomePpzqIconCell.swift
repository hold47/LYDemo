//
//  LYHomePpzqIconCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/13.
//

import UIKit

class LYHomePpzqIconCell: BaseCollectionViewCell {
    @IBOutlet weak var icon: UIImageView!
    var model: LYBrandModel? {
        didSet {
            icon.setImage(model?.image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initSubviews()
    }
    
    override func initSubviews() {
//        contentView.borderWidth = 0.5
//        contentView.borderColor = UIColor(hexString: "#EEEEEE")
    }

}

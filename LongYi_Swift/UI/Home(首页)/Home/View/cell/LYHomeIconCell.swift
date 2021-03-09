//
//  LYHomeIconCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/6.
//

import UIKit

class LYHomeIconCell: BaseCollectionViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var model: LYADModel? {
        didSet {
            icon.setImage(model?.image)
            titleLabel.text = model?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

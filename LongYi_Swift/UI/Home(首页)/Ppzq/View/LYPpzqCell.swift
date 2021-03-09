//
//  LYPpzqCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/25.
//

import UIKit

class LYPpzqCell: UICollectionViewCell {
    
    var model: LYBrandModel? {
        didSet {
            icon.setImage(model?.image)
        }
    }
    
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

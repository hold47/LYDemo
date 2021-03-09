//
//  LYHomeChoujiangCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/12.
//

import UIKit

class LYHomeChoujiangCell: BaseCollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView! {
        didSet {
            icon.cornerRadius = 5
        }
    }
    var model: LYADModel? {
        didSet {
            icon.setImage(model?.image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

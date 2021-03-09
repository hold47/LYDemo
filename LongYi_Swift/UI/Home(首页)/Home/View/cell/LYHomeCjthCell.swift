//
//  LYHomeCjthCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2021/3/5.
//

import UIKit

class LYHomeCjthCell: BaseCollectionViewCell {
    
    var model: LYADModel? {
        didSet {
            icon.setImage(model?.image)
        }
    }
    
    @IBOutlet weak var icon: UIImageView! {
        didSet {
            icon.cornerRadius = 8
        }
    }

}

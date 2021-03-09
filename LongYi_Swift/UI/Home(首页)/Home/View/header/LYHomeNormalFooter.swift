//
//  LYHomeNormalFooter.swift
//  LongYi_Swift
//
//  Created by Hold on 2021/3/5.
//

import UIKit

class LYHomeNormalFooter: BaseCollectionReusableView {
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.cornerRadius = 8
        }
    }
    
}

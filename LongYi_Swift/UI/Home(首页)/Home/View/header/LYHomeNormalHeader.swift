//
//  LYHomeNormalHeader.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/6.
//

import UIKit

class LYHomeNormalHeader: BaseCollectionReusableView {
    
    var bgColor: UIColor = .white {
        didSet {
            bgView.backgroundColor = bgColor
            bgView2.backgroundColor = bgColor
        }
    }
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.cornerRadius = 8
        }
    }
    @IBOutlet weak var bgView2: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton! {
        didSet {
            moreButton.layoutImage(type: .right, space: 5)
        }
    }
    
}

//
//  LYHomeYjhFooter.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/16.
//

import UIKit

class LYHomeYjhFooter: BaseCollectionReusableView {
    
    @IBOutlet weak var bgView2: UIView! {
        didSet {
            bgView2.backgroundColor = Constant.yjhColor
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.backgroundColor = Constant.yjhColor
            bgView.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var moreButton: UIButton! {
        didSet {
            moreButton.cornerRadius = 5
        }
    }
    
}

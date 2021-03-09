//
//  LYMultiRegisterHeaderView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/2.
//

import UIKit

class LYMultiRegisterHeaderView: UIView {

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var switchButton: UIButton! {
        didSet {
            switchButton.layoutImage(type: .right, space: 5)
            switchButton.imageForNormal = UIImage(named: "arrow_down_gray")
            switchButton.imageForSelected = UIImage(named: "arrow_up_gray")
        }
    } 

}

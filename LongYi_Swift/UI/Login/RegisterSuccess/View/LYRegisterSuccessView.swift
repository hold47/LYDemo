//
//  LYRegisterSuccessView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/30.
//

import UIKit

class LYRegisterSuccessView: UIView {
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.cornerRadius = loginButton.height * 0.5
        }
    }
    @IBOutlet weak var wechatButton: UIButton! {
        didSet {
            wechatButton.cornerRadius = wechatButton.height * 0.5
            wechatButton.borderColor = Constant.mainColor
            wechatButton.borderWidth = 1
        }
    }

}

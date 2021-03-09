//
//  LYForgetPasswordSuccessView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/3.
//

import UIKit

class LYForgetPasswordSuccessView: UIView {
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.cornerRadius = loginButton.height * 0.5
        }
    }
}

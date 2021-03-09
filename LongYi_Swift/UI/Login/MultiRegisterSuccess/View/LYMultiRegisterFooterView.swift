//
//  LYMultiRegisterFooterView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/2.
//

import UIKit

class LYMultiRegisterFooterView: UIView {

    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.cornerRadius = loginButton.height * 0.5
        }
    }
    @IBOutlet weak var bindButton: UIButton! {
        didSet {
            bindButton.cornerRadius = bindButton.height * 0.5
            bindButton.borderWidth = 1
            bindButton.borderColor = UIColor(hexString: "#22A7F0")
        }
    }
    
    
    

}

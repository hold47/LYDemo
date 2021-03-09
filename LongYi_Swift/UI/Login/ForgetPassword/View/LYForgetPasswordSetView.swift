//
//  LYForgetPasswordSetView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/3.
//

import UIKit

//  MARK: - UI
class LYForgetPasswordSetView: UIView {
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var resetButton: UIButton! {
        didSet {
            resetButton.cornerRadius = resetButton.height * 0.5
        }
    }
}

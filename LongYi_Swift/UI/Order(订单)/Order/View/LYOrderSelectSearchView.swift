//
//  LYOrderSelectSearchView.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/6.
//

import UIKit

class LYOrderSelectSearchView: UIView {

    @IBOutlet weak var startTF: UITextField! {
        didSet {
            startTF.cornerRadius = 12
            startTF.placeholder = "请选择开始日期"
            startTF.textAlignment = .center
        }
    }
    @IBOutlet weak var endTF: UITextField! {
        didSet {
            endTF.cornerRadius = 12
            endTF.placeholder = "请选择结束日期"
            endTF.textAlignment = .center
        }
    }
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.cornerRadius = 12
        }
    }
    
}

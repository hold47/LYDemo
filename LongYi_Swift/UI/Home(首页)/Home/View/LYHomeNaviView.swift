//
//  LYHomeNaviView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/4.
//

import UIKit

class LYHomeNaviView: UIView {
    @IBOutlet weak var orderButton: UIButton! {
        didSet {
            orderButton.layoutImage(type: .top, space: 5)
        }
    }
    @IBOutlet weak var messageButton: UIButton! {
        didSet {
            messageButton.layoutImage(type: .top, space: 5)
        }
    }
    @IBOutlet weak var searchView: UIView! {
        didSet {
            searchView.cornerRadius = searchView.height * 0.5
        }
    }

}

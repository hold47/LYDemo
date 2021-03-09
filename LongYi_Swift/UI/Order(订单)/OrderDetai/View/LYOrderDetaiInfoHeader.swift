//
//  LYOrderDetaiInfoHeader.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/7.
//

import UIKit

class LYOrderDetaiInfoHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
//            bgView.roundCorners([.topLeft, .topRight], radius: 8)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

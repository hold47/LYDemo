//
//  LYOrderDetailInfoFooter.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/8.
//

import UIKit

class LYOrderDetailInfoFooter: UITableViewHeaderFooterView {
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
//            bgView.cornerRadius = 8
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

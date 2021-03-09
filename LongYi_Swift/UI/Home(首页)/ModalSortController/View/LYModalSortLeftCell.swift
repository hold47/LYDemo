//
//  LYModalSortLeftCell.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/11.
//

import UIKit

class LYModalSortLeftCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var greenLine: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Constant.tableViewBgColor
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            titleLabel.textColor = Constant.mainColor
            greenLine.backgroundColor = Constant.mainColor
            greenLine.isHidden = false
        } else {
            titleLabel.textColor = UIColor(hexString: "333333")
            greenLine.isHidden = true
        }
    }
}

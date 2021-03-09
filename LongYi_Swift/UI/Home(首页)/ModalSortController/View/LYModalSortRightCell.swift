//
//  LYModalSortRightCell.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/11.
//

import UIKit

class LYModalSortRightCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            titleLabel.textColor = Constant.mainColor
        } else {
            titleLabel.textColor = UIColor(hexString: "333333")
        }
    }
    
}

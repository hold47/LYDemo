//
//  LYGoodsDetailCell.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/2.
//

import UIKit

class LYGoodsDetailCell: BaseTableViewCell {
    
    var content: String? {
        didSet {
            guard let data = content?.data(using: .unicode) else { return }
            //  展示H5富文本
            let attriString = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html] , documentAttributes: nil)
            contentLabel.attributedText = attriString
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

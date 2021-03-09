//
//  LYCartOrderConfirmFooter.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/13.
//

import UIKit

class LYCartOrderConfirmFooter: UITableViewHeaderFooterView {
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.cornerRadius = 8
        }
    }
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var payTypeLabel: UILabel!
    @IBOutlet weak var wordTextView: UITextField!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Constant.tableViewBgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}

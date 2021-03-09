//
//  BaseTableViewCell.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/9/28.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    lazy var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

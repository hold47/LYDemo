//
//  BaseCollectionViewCell.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/11.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    lazy var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}

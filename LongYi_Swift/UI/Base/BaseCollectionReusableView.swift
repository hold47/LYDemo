//
//  BaseCollectionReusableView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/10.
//

import Foundation

class BaseCollectionReusableView: UICollectionReusableView {
    
    lazy var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}

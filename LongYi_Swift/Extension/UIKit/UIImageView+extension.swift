//
//  UIimageView+extension.swift
//  firefly20200330
//
//  Created by Hold on 2020/5/14.
//  Copyright © 2020 mumu. All rights reserved.
//

import UIKit

extension UIImageView {
    
    convenience init(_ imageName: String) {
        let image = UIImage(named: imageName)
        self.init(image: image)
    }
    
    /// 使用KF设置图片
    func setImage(_ url: String?) {
        kf.indicatorType = .activity
        kf.setImage(with: URL(string: url), placeholder: Constant.placeHolder)
    }
    
}

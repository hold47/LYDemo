//
//  UIButton+extension.swift
//  firefly20200330
//
//  Created by Hold on 2020/5/25.
//  Copyright © 2020 mumu. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(text: String, textColorHex: String, font: UIFont) {
        self.init(type: .custom)
        
        setTitle(text, for: .normal)
        setTitleColor(UIColor(hexString: textColorHex), for: .normal)
        titleLabel?.font = font
    }
    
    convenience init(text: String, textColor: UIColor, font: UIFont) {
        self.init(type: .custom)
        
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = font
    }
    
    convenience init(imageName: String) {
        self.init(type: .custom)
        
        setImage(UIImage(named: imageName), for: .normal)
    }
}

//  MARK: - Image Position
enum ButtonImagePositionType {
    case top
    case left
    case bottom
    case right
}

extension UIButton {
    
    func layoutImage(type: ButtonImagePositionType, space: CGFloat) {
        /**
         *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
         *  如果只有title，那它上下左右都是相对于button的，image也是一样；
         *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
         */
        
        // 1. 得到imageView和titleLabel的宽、高
        sizeToFit()
        clipsToBounds = false
        let imageWith = imageView?.frame.size.width ?? 0
        let imageHeight = imageView?.frame.size.height ?? 0
        
        var labelWidth: CGFloat = 0
        var labelHeight: CGFloat = 0
        
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = titleLabel?.intrinsicContentSize.width ?? 0
        labelHeight = titleLabel?.intrinsicContentSize.height ?? 0
        
        // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero;
        var labelEdgeInsets = UIEdgeInsets.zero;
        
        // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch (type) {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space * 0.5, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith, bottom: -imageHeight - space * 0.5, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space * 0.5, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - space * 0.5, left: -imageWith, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: -labelWidth - space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith - space * 0.5, bottom: 0, right: imageWith + space * 0.5)
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
}

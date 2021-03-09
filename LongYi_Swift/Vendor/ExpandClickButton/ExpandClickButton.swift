//
//  ExpandClickButton.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/25.
//

import UIKit

/// 扩大点击范围
class ExpandClickButton: UIButton {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let margin: CGFloat = 20
        let area = self.bounds.insetBy(dx: -margin, dy: -margin) //负值是方法响应范围
        return area.contains(point)
    }
}

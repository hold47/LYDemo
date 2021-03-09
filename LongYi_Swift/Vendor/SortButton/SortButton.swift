//
//  SortButton.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/9/28.
//

import UIKit

enum HKSortButtonType {
    case none
    case up
    case down
}

class HKSortButton: UIControl {
    /// 选中状态 默认none
    var type: HKSortButtonType = .none {
        didSet {
            setNeedsDisplay()
        }
    }
    /// 标题
    var title: String?
    /// 字体大小 默认14
    var textFont: UIFont = UIFont.systemFont(ofSize: 14)
    /// 三角形宽度 默认10
    var triangelWidth: CGFloat = 10
    /// 选中颜色 默认红色
    var selectColor: UIColor = .red
    /// 非选中颜色 默认灰色
    var unselectColor: UIColor = .darkText
    
    convenience init(title: String, frame: CGRect) {
        self.init(frame: frame)
        self.title = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// 取相反值
    func opposite() {
        if type == .down {
            type = .up
        } else {
            type = .down
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        guard let title = title?.nsString, title.length > 0 else { return }
        
        let textRect = title.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        let textW = textRect.width
        let textH = textRect.height
        let triangleW = triangelWidth > 0 ? triangelWidth : 10
        let trianglePadding = 4.cgFloat
        let textColor = type == .none ? unselectColor : selectColor
        
        title.draw(in: CGRect(x: (width - textW - triangelWidth) / 2, y: (height - textH) / 2, width: textW, height: height), withAttributes: [NSAttributedString.Key.font : textFont, NSAttributedString.Key.foregroundColor: textColor])
            
        //  绘制上面的三角形
        if type == .up {
            context.setFillColor(selectColor.cgColor)
        } else {
            context.setFillColor(unselectColor.cgColor)
        }
        let x1 = (width + textW) * 0.5 + trianglePadding
        let y1 = (height - triangleW) * 0.5 - 1
        context.move(to: CGPoint(x: x1, y: y1))
        
        let x2 = x1 + triangleW * 0.5
        let y2 = y1 + triangleW * 0.5
        context.addLine(to: CGPoint(x: x2, y: y2))
        
        let x3 = x1 - triangleW * 0.5
        let y3 = y2
        context.addLine(to: CGPoint(x: x3, y: y3))
        
        context.closePath()
        context.fillPath()

        //  绘制下面的三角形
        if type == .down {
            context.setFillColor(selectColor.cgColor)
        } else {
            context.setFillColor(unselectColor.cgColor)
        }
        
        let a1 = x1
        let b1 = y1 + triangleW + 2
        context.move(to: CGPoint(x: a1, y: b1))
        
        let a2 = x2
        let b2 = y2 + 2
        context.addLine(to: CGPoint(x: a2, y: b2))
        
        let a3 = x3
        let b3 = y3 + 2
        context.addLine(to: CGPoint(x: a3, y: b3))
        
        context.closePath()
        context.fillPath()
    }

}

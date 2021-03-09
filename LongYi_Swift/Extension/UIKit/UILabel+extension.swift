//
//  UILabel+extension.swift
//  swift4Demo
//
//  Created by 命运 on 9/25/18.
//  Copyright © 2018 com.org.shunshiwei. All rights reserved.
//

import UIKit

extension UILabel {
    
	convenience init(text: String, fontSize: CGFloat, TextAlignment: NSTextAlignment, textColor: UIColor?) {
		self.init()
		self.text = text
		self.font = UIFont.systemFont(ofSize: fontSize)
		self.textAlignment = TextAlignment
        self.textColor = textColor ?? UIColor.darkText
	}
    
    convenience init(text: String, textColor: UIColor?, font: UIFont) {
        self.init()
        self.numberOfLines = 0
        self.text = text
        self.textColor = textColor ?? UIColor.darkText
        self.font = font
    }
    
    /// ¥ 88格式
    /// - Parameter logoFont: ¥字体大小
    func RMBStyle(logoFont: UIFont) {
        if text?.hasPrefix("¥") ?? false {
            let attri = NSMutableAttributedString(string: text!)
            attri.addAttribute(.font, value: logoFont, range: NSRange(location: 0, length: 1))
            attributedText = attri
        }
    }

}

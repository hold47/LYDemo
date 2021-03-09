//
//  UIView+extension.swift
//  WineLife
//
//  Created by TJL on 2019/9/18.
//  Copyright © 2019 jmq. All rights reserved.
//

import UIKit

extension UIView {
    
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    /// 加载xib
    func loadViewFromNib() -> UIView? {
        let className = type(of: self)
        let fullName = NSStringFromClass(className)
        guard let name = fullName.split(separator: ".").map({ String($0) }).last else { return nil }
        return Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? UIView
    }
    
    /// 截图   swifterswift里类似screenshot
    public func snapShot(size: CGSize?) -> UIImage? {
        var size = size
        if size == nil {
            size = bounds.size
        }
        
        UIGraphicsBeginImageContextWithOptions(size!, true, UIScreen.main.scale);
        let context = UIGraphicsGetCurrentContext()
        layer.render(in: context!)
        let shotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return shotImage
    }
    
}

//  布局相关
extension UIView {
    
    public func addConstraint(inSuper attribute: NSLayoutConstraint.Attribute, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: .equal,
                                            toItem: superview,
                                            attribute: attribute,
                                            multiplier: 1.0,
                                            constant: constant)
        superview?.addConstraint(constraint)
    }
    
    public func addConstraint(width: CGFloat) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: width)
        superview?.addConstraint(constraint)
    }
    
    public func addConstraint(height: CGFloat) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: height)
        superview?.addConstraint(constraint)
    }
    
    public func updateConstraint(inSuper attribute: NSLayoutConstraint.Attribute, constant: CGFloat) {
        guard let superView = superview else {
            print("superview didon't exsit")
            return
        }
        
        for constraint in superView.constraints {
            if (constraint.firstAttribute == attribute && constraint.firstItem as? UIView == self) ||
                (constraint.firstAttribute == attribute && constraint.secondItem as? UIView == self) {
                constraint.constant = constant
                break
            }
        }
    }
    
    public func updateConstraint(forWidth width: CGFloat) {
        for constraint in constraints {
            if constraint.firstAttribute == .width && constraint.firstItem as? UIView == self {
                constraint.constant = width
            }
        }
    }
    
    public func updateConstraint(forHeight height: CGFloat) {
        for constraint in constraints {
            if constraint.firstAttribute == .height && constraint.firstItem as? UIView == self {
                constraint.constant = height
            }
        }
    }
    
}

extension UIView {
    
    @objc dynamic func initSubviews() {}
    @objc dynamic func UIActions() {}
    
    var midX: CGFloat {
        get { return frame.midX }
        set { x = newValue - width / 2 }
    }
    
    var midY: CGFloat {
        get { return frame.midY }
        set { y = newValue - height / 2 }
    }
    
    var maxX: CGFloat {
        get { return frame.maxX }
        set { x = newValue - width }
    }
    
    var maxY: CGFloat {
        get { return frame.maxY }
        set { y = newValue - height }
    }
    
}



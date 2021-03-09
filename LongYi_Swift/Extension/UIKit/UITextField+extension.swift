//
//  UITextField+extension.swift
//  WineLife
//
//  Created by TJL on 2019/10/1.
//  Copyright © 2019 jmq. All rights reserved.
//

import UIKit

extension UITextField{
    /// 添加输入框左侧图标
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - size: 显示大小
    ///   - viewMode: 显示的时机
    func setImageTextFieldLeft(imageName:String,size:CGSize,viewMode:ViewMode = ViewMode.always){
        self.leftViewMode = viewMode
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        contentView.addSubview(imageView)
        self.leftView = contentView
    }
    
    /// 添加输入框右侧图标
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - size: 显示大小
    func setImageTextFieldRight(imageName:String,size:CGSize){
        self.rightViewMode = .always
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        contentView.addSubview(imageView)
        self.rightView = contentView
    }
    
    /// 添加左侧间距
    func addLeftSpace(){
        addLeftSpace(space: 5)
    }
    
    /// 添加左侧间距
    /// - Parameter space: 距离大小
    func addLeftSpace(space:Int){
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: 0))
        self.leftViewMode = .always
    }
}

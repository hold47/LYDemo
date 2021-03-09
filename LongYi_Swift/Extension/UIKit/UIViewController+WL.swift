//
//  UIViewController+WL.swift
//  WineLife
//
//  Created by 超神—mayong on 2019/9/21.
//  Copyright © 2019 jmq. All rights reserved.
//

import UIKit.UIViewController


extension UIViewController {
        
//    func present(_ viewControllerToPresent: UIViewController, completion: (() -> Void)?) {
//        viewControllerToPresent.modalPresentationStyle = .overFullScreen
//        DispatchQueue.main.async {
//             self.present(viewControllerToPresent, animated: true, completion: completion)
//        }
//    }
    
    /// 弹出列表
    /// - Parameters:
    ///   - title: 主题
    ///   - message: 描述
    ///   - cancelTitle: 取消title文字
    ///   - otherBtnTitles: 其他文本列表
    ///   - action: 操作回调
    func showSheet(title : String? , message : String ,cancelTitle:String?,otherBtnTitles:[String],action:@escaping (_ index : Int) ->Void){
        let alertView = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        for (index,value) in otherBtnTitles.enumerated() {
            
            let confirm = UIAlertAction.init(title: value, style: UIAlertAction.Style.default, handler:{
                (handleAction) in
                action(index)
            })
            alertView.addAction(confirm)
        }
        if cancelTitle != nil {
            let confirm = UIAlertAction.init(title: cancelTitle, style: UIAlertAction.Style.cancel, handler:{
                (handleAction) in
                action(-1)
            })
            alertView.addAction(confirm)
        }
        self.present(alertView, animated: true, completion: nil)
    }
    
}

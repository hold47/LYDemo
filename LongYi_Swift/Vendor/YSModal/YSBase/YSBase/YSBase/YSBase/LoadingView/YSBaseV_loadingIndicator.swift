//  Created by yaoshuai on 2018/5/22.
//  Copyright © 2018 ys. All rights reserved.

import UIKit

/// 如果想使某一个view有loading效果，请继承此类
class YSBaseV_loadingIndicator: UIView {
    
    // loadingIndicatorView
    private var loadingIndicatorView:YSLoadingIndicatorView?
    
    // 需要自定义loadingIndicatorView，重写这个方法
    open func ys_createLoadingIndicatorView() -> YSLoadingIndicatorView{
        return YSLoadingIndicatorView_default(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    }
    
    // 以下2个方法外界直接调用
    public func ys_startLoadingIndicatorView(){
        if loadingIndicatorView == nil{
            loadingIndicatorView = ys_createLoadingIndicatorView()
        }
        if !subviews.contains(loadingIndicatorView!){
            addSubview(loadingIndicatorView!)
        }
        bringSubviewToFront(loadingIndicatorView!)
        
        loadingIndicatorView!.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: loadingIndicatorView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loadingIndicatorView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        loadingIndicatorView!.ys_startLoadingIndicatorView()
    }
    
    public func ys_stopLoadingIndicatorView(){
        loadingIndicatorView?.ys_stopLoadingIndicatorView()
        loadingIndicatorView?.removeFromSuperview()
        loadingIndicatorView = nil
    }
}

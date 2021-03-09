//
//  UIScrollView+extension.swift
//  firefly20200330
//
//  Created by Hold on 2020/5/28.
//  Copyright © 2020 mumu. All rights reserved.
//

import UIKit

//  MARK: - MJRefresh
var handleKey = 100
extension UIScrollView {
    
    var handleClosure: (() -> ())? {
        set {
            objc_setAssociatedObject(self, &handleKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let result = objc_getAssociatedObject(self, &handleKey) as? (() -> ()) {
                return result
            }
            return nil
        }
    }
    
    /// 添加头部刷新
    func addHeader(handle: (()->())?) {
//        let header = RefreshHeader(refreshingBlock: handle)
//        header.lastUpdatedTimeLabel?.isHidden = true
//        header.stateLabel?.isHidden = true
//        mj_header = header
        
        //  使用原生的refresh
        let refresh = UIRefreshControl()
        self.refreshControl = refresh
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        handleClosure = handle
    }
    
    @objc func refreshAction() {
        handleClosure?()
    }
    
    /// 添加加载更多
    func addFooter(handle: @escaping (()->())) {
        let footer = MJRefreshAutoStateFooter(refreshingBlock: handle)
//        let footer = MJRefreshBackNormalFooter(refreshingBlock: handle)
        footer.setTitle("已经到底了", for: .noMoreData)
        footer.stateLabel?.textColor = UIColor(hexString: "999999")
        footer.stateLabel?.font = UIFont.systemFont(ofSize: 12)
        footer.isHidden = true
        mj_footer = footer
    }
    
    /// 停止刷新
    func endRefreshing() {
        if refreshControl?.isRefreshing ?? false {
            refreshControl?.endRefreshing()
        } else {
            mj_footer?.endRefreshing()
        }
        
        if mj_header?.isRefreshing ?? false {
            mj_header?.endRefreshing()
        } else {
            mj_footer?.endRefreshing()
        }
    }
            
    /// 无更多
    func noMoreData() {
        mj_footer?.endRefreshingWithNoMoreData()
    }
    
    /// 可以加载更多
    func resetNoMoreData() {
        mj_footer?.resetNoMoreData()
    }
    
}

extension UIScrollView {
    
    /// 截图
    func snapShot() -> UIImage? {
        let savedContentOffset = contentOffset
        let savedFrame = frame
        
        frame = CGRect(x: 0,
                            y: frame.origin.y,
                        width: contentSize.width,
                       height: contentSize.height)
        
        UIGraphicsBeginImageContextWithOptions(contentSize, true, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        layer.render(in: context!)
        let shotImage = UIGraphicsGetImageFromCurrentImageContext()
        
        contentOffset = savedContentOffset
        frame = savedFrame
        
        return shotImage
    }
    
}

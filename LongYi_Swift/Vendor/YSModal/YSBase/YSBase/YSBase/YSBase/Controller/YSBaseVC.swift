//  Created by yaoshuai on 2018/5/22.
//  Copyright © 2018 ys. All rights reserved.

import UIKit

open class YSBaseVC: UIViewController {
    
    // loadingIndicatorView
    private var loadingIndicatorView:YSLoadingIndicatorView?
    
    private var _viewWillAppear_times = 0
    private var _viewDidAppear_times = 0
    private var _viewWillDisappear_times = 0
    private var _viewDidDisappear_times = 0
    private var _viewDidLayoutSubviews_times = 0
    
    /// 别名(子类可重写)，只读属性，默认为控制器的描述
    open var ys_alias: String{
        return description
    }
    
    /// 是否是第一次执行viewWillAppear，使用之前请务必执行super.viewWillAppear()
    public var viewWillAppear_first:Bool{ return _viewWillAppear_times < 2 }
    
    /// 是否是第一次执行viewDidAppear，使用之前请务必执行super.viewDidAppear()
    public var viewDidAppear_first:Bool{ return _viewDidAppear_times < 2 }
    
    /// 是否是第一次执行viewWillDisappear，使用之前请务必执行super.viewWillDisappear()
    public var viewWillDisappear_first:Bool{ return _viewWillDisappear_times < 2 }
    
    /// 是否是第一次执行viewDidDisappear，使用之前请务必执行super.viewDidDisappear()
    public var viewDidDisappear_first:Bool{ return _viewDidDisappear_times < 2 }
    
    /// 是否是第一次执行viewDidLayoutSubviews，使用之前请务必执行super.viewDidLayoutSubviews()
    public var viewDidLayoutSubviews_first:Bool{ return _viewDidLayoutSubviews_times < 2 }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        init_execute()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        init_execute()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        _viewWillAppear_times = 0
        _viewDidAppear_times = 0
        _viewWillDisappear_times = 0
        _viewDidDisappear_times = 0
        _viewDidLayoutSubviews_times = 0
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _viewWillAppear_times += 1
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _viewDidAppear_times += 1
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _viewWillDisappear_times += 1
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _viewDidDisappear_times += 1
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _viewDidLayoutSubviews_times += 1
    }
    
    // MARK: - loading动画
    
    // 需要自定义loadingIndicatorView，重写这个方法
    open func ys_createLoadingIndicatorView() -> YSLoadingIndicatorView{
        return YSLoadingIndicatorView_default(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    }
    
    public func ys_startLoadingIndicatorView(){
        if loadingIndicatorView == nil{
            loadingIndicatorView = ys_createLoadingIndicatorView()
        }
        if !view.subviews.contains(loadingIndicatorView!){
            view.addSubview(loadingIndicatorView!)
        }
        view.bringSubviewToFront(loadingIndicatorView!)
        
        loadingIndicatorView!.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: loadingIndicatorView!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: loadingIndicatorView!, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
        
        loadingIndicatorView!.ys_startLoadingIndicatorView()
    }
    
    public func ys_stopLoadingIndicatorView(){
        loadingIndicatorView?.ys_stopLoadingIndicatorView()
        loadingIndicatorView?.removeFromSuperview()
        loadingIndicatorView = nil
    }
    
    
    // MARK: - init 的一些扩展方法
    
    /// 初始化后执行的扩展方法
    open func init_execute(){
        
    }
    
    deinit {
        #if DEBUG
        print("~~~~~~~~~~~~♻️♻️♻️♻️\(self) deinit ♻️♻️♻️♻️~~~~~~~~~~~~")
        #endif
    }
}

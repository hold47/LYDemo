//
//  BaseViewController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/27.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var disposeBag = DisposeBag()
    lazy var noDataTips = "暂无数据"
    
    /// 是否隐藏导航栏底部阴影
    var isHideNaviBottomShadow: Bool = true {
        didSet {
            navigationController?.navigationBar.shadowImage = isHideNaviBottomShadow ? UIImage() : nil
        }
    }
    
    /// 导航栏是否透明
    var isHideNaviBarColor: Bool = true {
        didSet {
            let whiteImage = UIImage(color: .white, size: CGSize(width: 1, height: 1))
            if isHideNaviBarColor {
                navigationController?.navigationBar.shadowImage = whiteImage
                navigationController?.navigationBar.setBackgroundImage(whiteImage, for: .default)
            } else {
                navigationController?.navigationBar.shadowImage = nil
                navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            }
        }
    }
    
    /// 是否使用maincolor背景色导航栏,  true = main   false = lanse那种
    var isMainColorNavigationBar: Bool = false {
        didSet {
            if isMainColorNavigationBar {
                let mainColorImage = UIImage(color: Constant.mainColor, size: CGSize(width: 1, height: 1))
                navigationController?.navigationBar.shadowImage = mainColorImage
                navigationController?.navigationBar.setBackgroundImage(mainColorImage, for: .default)
                navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navi_arrow_left_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(naviPopAction))
            } else {
                let blueColorImage = UIImage(color: UIColor(hexString: "#22A7F0")!, size: CGSize(width: 1, height: 1))
                navigationController?.navigationBar.shadowImage = blueColorImage
                navigationController?.navigationBar.setBackgroundImage(blueColorImage, for: .default)
                navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navi_arrow_left_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(naviPopAction))
            }
        }
    }
    
    /// 自定义导航栏返回按钮
    func configNavStyle() {
        if (navigationController?.viewControllers.count ?? 0) > 1 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navi_arrow_left_gray")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(naviPopAction))
            navigationController?.navigationBar.shadowImage = isHideNaviBottomShadow ? UIImage() : nil
            navigationController?.navigationBar.isTranslucent = false
            //  使用自定义返回按钮,系统侧滑手势默认就不能使用了
            //        navigationController?.interactivePopGestureRecognizer?.delegate = self
            //        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    @objc func naviPopAction() {
        navigationController?.popViewController(animated: true)
    }
    
//    /// 自定义导航栏返回按钮
//    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
//        let button = UIButton(type: .custom)
//        button.size = CGSize(width: 44, height: 44)
//        button.imageForNormal = UIImage(named: "arrow_left_black")
//        button.sizeToFit()
//        button.addTarget(target, action: action, for: .touchUpInside)
//        return UIBarButtonItem(customView: button)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //  是否延伸到状态栏
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = .bottom
        view.backgroundColor = .white
        isHideNaviBarColor = true
        isHideNaviBottomShadow = true
        configNavStyle()
    }
    
    /// 初始化子控件  viewDidLoad里添加子控件 viewdidlayoutsubivew里布局
    @objc dynamic func initSubViews() {}
    /// 数据绑
    @objc dynamic func bind() {}
    /// 处理点击事件
    @objc dynamic func UIActions() {}
    /// 加载数据
    @objc dynamic func loadData() {}
    /// 上拉加载
    @objc dynamic func loadmore() {}
    /// 路由跳转
    @objc dynamic func router(name: String, index: Int) {}

    
    deinit {
        #if DEBUG
        print("~~~~~~~~~~~~♻️♻️♻️♻️\(self) deinit ♻️♻️♻️♻️~~~~~~~~~~~~")
        #endif
    }
    
}

//  MARK: - EmptyDataSet
extension BaseViewController: EmptyDataSetSource, EmptyDataSetDelegate {
    
    func addEmptyDataSet(_ view: UIScrollView, _ tipStr: String? = nil) {
        if tipStr != nil {
            noDataTips = tipStr!
        }
        view.emptyDataSetSource = self
        view.emptyDataSetDelegate = self
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var tipStr = noDataTips
        let networkState = UserPreference.shared.netWorkStateRelay.value
        if networkState == .notReachable || networkState == .unknown {
            tipStr = "网络连接失败,请点击刷新"
        }
        let att = NSMutableAttributedString(string: tipStr)
        let attrStyle: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: "333333")!,
            .font :UIFont.systemFont(ofSize: 16)
        ]
        att.addAttributes(attrStyle, range: NSMakeRange(0, tipStr.count))
        return att
    }
    
    @objc func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -100
    }
    
    @objc func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 30
    }
    
    @objc func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "emptyData")
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func buttonImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {        
        return nil
    }
    
    //  点击刷新界面
    func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        loadData()
    }
    
}

extension BaseViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

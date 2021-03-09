//
//  BaseWebViewController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/5.
//

import UIKit
import WebKit

class BaseWebViewController: BaseViewController {
    
    var webView = WKWebView()
    var progressView: UIProgressView? = UIProgressView()
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
        bind()
        loadData()
    }
    
    override func initSubViews() {
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        webView.scrollView.showsVerticalScrollIndicator = false
        addEmptyDataSet(webView.scrollView, "加载失败")
        
        /// 进度条设置
//        progressView?.backgroundColor = .white
        progressView?.progressTintColor = Constant.mainColor
        progressView?.isHidden = true
        navigationController?.navigationBar.addSubview(progressView!)
        progressView?.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1.5)
        }
        
        /// 刷新按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_refresh"), style: .plain, target: self, action: #selector(refreshWeb))        
    }
    
    override func bind() {
        //  kvo监听estimatedProgress属性变化
        webView.rx.observe(Double.self, "estimatedProgress").subscribe(onNext: { [weak self] value in
            guard let v = value?.float else { return }
            self?.progressView?.progress = v
        }).disposed(by: disposeBag)
    }
    
    override func naviPopAction() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController()
        }
    }
    
    @objc func refreshWeb() {
        webView.reload()
    }
    
    override func loadData() {
        guard let urlString = urlString else { return }
        guard let request = URLRequest(urlString: urlString) else { return }
        guard  let cookies = HTTPCookieStorage.shared.cookies else { return }
        let cookiesStore = webView.configuration.websiteDataStore.httpCookieStore
        for cookie in cookies {
            cookiesStore.setCookie(cookie, completionHandler: nil)
        }
        webView.load(request)
    }
        
}

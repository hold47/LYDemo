//
//  LYH5ActivityController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/18.
//

import UIKit
import WebKit

class LYH5ActivityController: BaseWebViewController {
    
    let viewModel = LYH5ActivityViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        bind()
    }
    
    override func bind() {
        super.bind()
        
        //  后台获取支付订单号后进行支付请求
        viewModel.prepayRelay.skip(1).subscribe(onNext: { [weak self] data in
            if let model = data.pay {
                if self?.viewModel.payType == 1 {
                    self?.alipayRequest(model)
                } else {
                    self?.wechatRequest(model)
                }
            }
        }).disposed(by: disposeBag)
        
        //  监听h5支付,成功回调就刷新页面
        NotificationCenter.default.rx.notification(LYNotificationName.paySuccess).subscribe(onNext: { [weak self] _ in
            self?.loadData()
        }).disposed(by: disposeBag)
    }
    
    func wechatRequest(_ prepayModel: LYPrePayModel) {
        let request = PayReq()
        request.partnerId = prepayModel.partnerid ?? ""
        request.prepayId = prepayModel.prepayid ?? ""
        request.package = prepayModel.package ?? ""
        request.nonceStr = prepayModel.noncestr ?? ""
        request.timeStamp = UInt32(prepayModel.timestamp?.int ?? 0)
        request.sign = prepayModel.sign ?? ""
        request.type = 0
        WXApi.send(request) { (isSuccess) in
            if isSuccess {
                self.loadData()
            } else {
                HUD.show(.error("支付失败...")).hide(HUDLastTime)
            }
        }
    }
    
    func alipayRequest(_ prepayModel: LYPrePayModel) {
        AlipaySDK.defaultService()?.payOrder(prepayModel.ali_key, fromScheme: "yaoxiaomeng", callback: { [weak self] (_) in
            self?.loadData()
        })
    }
        
}

extension LYH5ActivityController: WKScriptMessageHandler {
    
    /// 从web界面中接收到一个脚本时调用,直接将接收到的JS脚本转为OC或Swift对象
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        LYPrint(message)
    }
    
}

extension LYH5ActivityController: WKNavigationDelegate {
    /// 开始调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let networkState = UserPreference.shared.netWorkStateRelay.value
        if networkState == .unknown || networkState == .notReachable {
            HUD.show(.error("请检查网络!")).hide(HUDLastTime)
        } else {
            navigationController?.navigationBar.bringSubviewToFront(progressView!)
            progressView?.isHidden = false
        }
    }
    /// 加载成功
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //  加载完成加一点视觉提示效果
        UIView.animate(withDuration: 0.25, delay: 0.3, options: .curveEaseOut, animations: {
            self.progressView?.transform = CGAffineTransform(scaleX: 1, y: 0.9)
        }) { _ in
            self.progressView?.isHidden = true
        }
    }
    /// 加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        HUD.show(.error("请检查网络!")).hide(2)
        progressView?.isHidden = true
    }
    /// 接受到服务器跳转请求后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    }
    /// 在发送请求之前,决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let scheme = navigationAction.request.url?.scheme, let url = navigationAction.request.url else { return }
        
        if scheme.contains("native") {
            pushVC(url: url)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    private func pushVC(url: URL) {
        guard let host = url.host else { return }
        
        if host.contains("list") {
            if url.path.contains("info") {
                LYPrint("跳转到详情")
            } else {
                LYPrint("跳转到普药")
            }
        }
        
        if host.contains("yhq") {
            LYPrint("跳转到优惠券")
        }
        
        if host.contains("yjh") {
            LYPrint("跳转到药聚会")
        }
        
        if host.contains("home") {
            LYTabBarController.shared.selectedIndex = 0
            navigationController?.popToRootViewController(animated: true)
        }
        
        if host.contains("cart") {
            LYTabBarController.shared.selectedIndex = 2
            navigationController?.popToRootViewController(animated: true)
        }
        
        if host.contains("kxzq") {
            LYPrint("跳转到控销专区")
        }
        
        if host.contains("ppzq") {
            LYPrint("跳转到品牌专区")
        }
        
        if host.contains("jfsc") {
            LYPrint("跳转到积分商城")
        }
        
        if host.contains("wechat") {
            let array = url.absoluteString.components(separatedBy: "/")
            let orderId = array.last ?? ""
            guard array.count > 3 else {
                LYPrint("数组越界")
                return
            }
            viewModel.payType = 2
            payAction(activityId: array[3], orderId: orderId)
        }
        
        if host.contains("alipay") {
            let array = url.absoluteString.components(separatedBy: "/")
            let orderId = array.last ?? ""
            guard array.count > 3 else {
                LYPrint("数组越界")
                return
            }
            viewModel.payType = 1
            payAction(activityId: array[3], orderId: orderId)
        }
   
    }
    
    private func payAction(activityId: String, orderId: String) {
        //  如果没有安装微信
        if viewModel.payType == 2 {
            if (WXApi.isWXAppInstalled() && WXApi.isWXAppSupport()) == false {
                HUD.show(.error("未安装微信或微信版本过低")).hide(HUDLastTime)
                return
            }
        }
        
        //  没有订单id就调用支付生成订单id并支付,有订单id就直接进行支付
        if orderId == "0" {
            viewModel.postActivityId(activityId, completion: nil)
        } else {
            viewModel.postOrderId(orderId, completion: nil)
        }
    }
    
}

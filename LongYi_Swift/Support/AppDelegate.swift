//
//  AppDelegate.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/26.
//

import UIKit
import XHLaunchAd
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LYTabBarController.shared
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

//        addLoginSessionObserver()
        
        startNetstateObserve()
        setupIQKeyboard()
        setupUM()
        setupXHLaunchAd()
        setupWeChat()
        
        return true
    }
        
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //  微信->APP
        if url.host == "oauth" {
            return WXApi.handleOpen(url, delegate: self)
        }
        //  支付宝->APP
        if url.host == "safepay" {
            AlipaySDK.defaultService()?.processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
                let model = LYOnlinePayModel()
                if model.resultStatus == 9000 {
                    NotificationCenter.default.post(name: LYNotificationName.paySuccess, object: nil)
                } else {
                    HUD.show(.error(model.memo)).hide(HUDLastTime)
                }
            })
        }
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return WXApi.handleOpenUniversalLink(userActivity, delegate: self)
    }

}

extension AppDelegate {
    
    /// IQKeyboard
    func setupIQKeyboard() {
        let manager = IQKeyboardManager.shared
        manager.enable = true
        manager.shouldResignOnTouchOutside = true
        manager.enableAutoToolbar = true
        manager.shouldToolbarUsesTextFieldTintColor = true
        manager.toolbarDoneBarButtonItemText = "完成"
        //  输入框和键盘之间的最小距离,若小于则自动上移
        manager.keyboardDistanceFromTextField = 20
    }
    
    /// 友盟
    func setupUM() {
        
    }
    
    /// 设置启动页
    func setupXHLaunchAd() {
        XHLaunchAd.setLaunch(.launchScreen)
        //  设为2即表示:启动页将停留2s等待服务器返回广告数据,2s内等到广告数据,将正常显示广告,否则将不显示
        XHLaunchAd.setWaitDataDuration(2)

        API.user.rx.request(User.launchAD).mapObject(LYLaunchModel.self).subscribe { result in
            switch result {
            case .success(let data):
                //  是否开启双11开关
                var is1111 = false
                is1111 = data.switch == 1 ? true : false
                UserDefaults.standard.setValue(is1111, forKey: "is1111")
                UserDefaults.standard.synchronize()
                
                let config = XHLaunchImageAdConfiguration()
                config.duration = 1
                config.imageNameOrURLString = data.data?.first?.image ?? ""
                config.imageOption = .default   // 图片缓存方式
                config.contentMode = .scaleToFill
                config.showFinishAnimate = .flipFromLeft
                config.showFinishAnimateTime = 0.8
                config.skipButtonType = .timeText
                config.showEnterForeground = false  //  后台返回时,是否显示广告
                XHLaunchAd.imageAd(with: config, delegate: self)
            case .error(let error):
                LYPrint(error)
            }
        }.disposed(by: disposeBag)
    }
}

//  MARK: - 微信
extension AppDelegate: WXApiDelegate {
    
    func startNetstateObserve() {
        UserPreference.shared.startNetstateObserve()
    }
    
    /// 设置微信
    func setupWeChat() {
        WXApi.registerApp(Constant.WeChatAppID, universalLink: Constant.WeChatLink)
    }
    
    func onReq(_ req: BaseReq) {
        
    }
    
    func onResp(_ resp: BaseResp) {
        if resp.errCode == 0 {
            //  这里判断是oauth授权回调还是支付回调
            if resp.isKind(of: SendAuthResp.self) {
                let response = resp as! SendAuthResp
                if response.state == "login" {
                    self.getWXAccessToken(code: response.code ?? "")
                } else if response.state == "bind" {
                    self.getWXAccessToken(code: response.code ?? "")
                }
            }
            
            if resp.isKind(of: PayResp.self) {
                NotificationCenter.default.post(name: LYNotificationName.paySuccess, object: nil, userInfo: nil)
            }
            
        } else if resp.errCode == -1 {
            HUD.show(.error("服务器异常")).hide(HUDLastTime)
        } else if resp.errCode == -2 {
            HUD.show(.error("用户取消")).hide(HUDLastTime)
        } else if resp.errCode == -4 {
            HUD.show(.error("用户拒绝授权")).hide(HUDLastTime)
        }
    }
    
    func getWXAccessToken(code: String) {
        let url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(Constant.WeChatAppID)&secret=\(Constant.WeChatAppSecret)&code=\(code)&grant_type=authorization_code"
        
        AF.request(url).response { response in
            guard let data = response.data else { return }
            guard let auth = try? JSONDecoder().decode(LYWeChatAuthModel.self, from: data) else { return }
            UserPreference.shared.setAuth(auth)
        }
        
    }
}


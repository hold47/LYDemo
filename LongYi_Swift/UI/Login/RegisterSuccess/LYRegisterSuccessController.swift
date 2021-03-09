//
//  LYRegisterSuccessController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/30.
//

import UIKit

extension LYRegisterSuccessController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
        refreshUI()
        bind()
        UIActions()
    }
    
    override func bind() {
        ///  使用信号监听微信授权成功
        UserPreference.shared.authRelay.skip(1).subscribe(onNext: { [weak self] auth in
            //  想服务器发送绑定
            self?.bindWeChat(unionid: auth?.unionid ?? "0", openid: auth?.openid ?? "0")
        }).disposed(by: disposeBag)
        
    }
    
    override func UIActions() {
        successView.loginButton.rx.tap.subscribe { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }.disposed(by: disposeBag)
        
        successView.wechatButton.rx.tap.subscribe { [weak self] _ in
            self?.wechatLogin()
        }.disposed(by: disposeBag)
    }
    
    func wechatLogin() {
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "bind"
        if WXApi.isWXAppInstalled() {
            WXApi.send(req)
        } else {
            HUD.show(.error("请先安装微信")).hide(HUDLastTime)
        }
    }
    
    func refreshUI() {
        successView.phoneLabel.text = viewModel.account?.phone?.string
        successView.nameLabel.text = viewModel.account?.username
    }
    
    func bindWeChat(unionid: String, openid: String) {
        HUD.show(.loading())
        viewModel.bindWechat(unionid: unionid) { [weak self] (error) in
            if error == LYRequestError.success {
                HUD.show(.success("绑定成功")).hide(HUDLastTime)
                self?.navigationController?.popToRootViewController(animated: true)
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }
    
}

//  MARK: - UI
class LYRegisterSuccessController: BaseViewController {
    
    let viewModel = LYRegisterSuccessViewModel()
    let successView = LYRegisterSuccessView.loadFromNib(named: "\(LYRegisterSuccessView.self)") as! LYRegisterSuccessView
    
    override func initSubViews() {
        isMainColorNavigationBar = true
        title = "会员注册完成"
        view.addSubview(successView)
        //  这里绑定微信的逻辑不通  暂不显示
        successView.wechatButton.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        successView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

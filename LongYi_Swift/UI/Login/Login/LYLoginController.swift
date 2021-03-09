//
//  LYLoginController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/27.
//

import UIKit

extension LYLoginController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        initSubViews()
        bind()
        UIActions()
    }
    
    override func bind() {
        ///  使用信号监听微信授权成功
        UserPreference.shared.authRelay.skip(1).subscribe(onNext: { [weak self] auth in
            //  向服务器发送微信登录
            HUD.show(.loading())
            self?.viewModel.wechatLogin { [weak self] (error) in
                if error == LYRequestError.success {
                    HUD.hide()
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                }
            }
        }).disposed(by: disposeBag)
        
        loginView.nameTF.rx.text.orEmpty.bind(to: viewModel.rx.name).disposed(by: disposeBag)
        loginView.passwordTF.rx.text.orEmpty.bind(to: viewModel.rx.password).disposed(by: disposeBag)
        loginView.phoneTF.rx.text.orEmpty.bind(to: viewModel.rx.phone).disposed(by: disposeBag)
        loginView.codeTF.rx.text.orEmpty.bind(to: viewModel.rx.code).disposed(by: disposeBag)
    }
    
    override func UIActions() {
        //  退出
        loginView.deleteButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true, completion: {
                LYTabBarController.shared.selectedIndex = 0
            })
        }).disposed(by: disposeBag)
        //  登录
        loginView.loginButton.rx.tap.subscribe(onNext: { [weak self] _ in
            let isAccountLogin = self?.loginView.type == .account
            //  账号登录
            if isAccountLogin {
                HUD.show(.loading())
                self?.viewModel.login { [weak self] (error) in
                    if error == LYRequestError.success {
                        HUD.hide()
                        LYTabBarController.shared.selectedIndex = 0
                        let navi = LYTabBarController.shared.selectedViewController as! BaseNavigationController
                        navi.popToRootViewController(animated: false)
                        self?.dismiss(animated: true, completion: nil)
                    } else {
                        HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                    }
                }
            } else {
            //  手机登录
                HUD.show(.loading())
                self?.viewModel.phoneLogin { (error) in
                    if error == LYRequestError.success {
                        HUD.hide()
                        LYTabBarController.shared.selectedIndex = 0
                        let navi = LYTabBarController.shared.selectedViewController as! BaseNavigationController
                        navi.popToRootViewController(animated: false)
                        self?.dismiss(animated: true, completion: nil)
                    } else {
                        HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                    }
                }
            }
        }).disposed(by: disposeBag)
        //  验证码
        loginView.codeButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.loginView.codeTF.becomeFirstResponder()
            self?.viewModel.sendCode({ (error) in
                if error == LYRequestError.success {
                    HUD.show(.success("已发送")).hide(HUDLastTime)
                } else {
                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                }
            })
        }).disposed(by: disposeBag)
        //  忘记密码
        loginView.forgetPasswordButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.navigationController?.pushViewController(LYForgetPasswordController())
        }).disposed(by: disposeBag)
        //  注册
        loginView.registerButton.rx.tap.subscribe(onNext: { [weak self] _ in
            let vc = LYRegisterController()
            self?.navigationController?.pushViewController(vc)
        }).disposed(by: disposeBag)
        //  协议
        loginView.protocalButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.navigationController?.pushViewController(LYRegisterProtocalController())
        }).disposed(by: disposeBag)
        //  微信登录
        loginView.wechatButton.rx.tap.subscribe(onNext: { _ in
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"
            req.state = "login"
            if WXApi.isWXAppInstalled() {
                WXApi.send(req)
            } else {
                HUD.show(.error("请先安装微信")).hide(HUDLastTime)
            }
        }).disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
        
}

//  MARK: - UI
class LYLoginController: BaseViewController {
    
    let viewModel = LYLoginViewModel()
    let loginView = LYLoginView.loadFromNib(named: "\(LYLoginView.self)") as! LYLoginView
    
    override func initSubViews() {
        view.addSubview(loginView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

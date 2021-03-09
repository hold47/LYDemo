//
//  LYRegisterController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/26.
//

import UIKit

extension LYRegisterController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册账号"
        
        isMainColorNavigationBar = true
        initSubViews()
        bind()
        UIActions()
    }
    
    override func bind() {
        registerView.phoneTextField.rx.text.orEmpty.bind(to: viewModel.rx.phone).disposed(by: disposeBag)
        registerView.codeTextField.rx.text.orEmpty.bind(to: viewModel.rx.code).disposed(by: disposeBag)
    }
    
    override func UIActions() {
        //  会员注册
        registerView.memberRegisterButton.rx.tap.subscribe { [weak self] _ in
            self?.type = .member
        }.disposed(by: disposeBag)
        //  多店注册
        registerView.shopRegisterButton.rx.tap.subscribe { [weak self] _ in
            self?.type = .shop
        }.disposed(by: disposeBag)
        //  验证码
        registerView.sendCodeButton.rx.tap.subscribe { [weak self] _ in
            self?.registerView.codeTextField.becomeFirstResponder()
            self?.viewModel.sendCode({ (error) in
                if error == LYRequestError.success {
                    HUD.show(.success("已发送")).hide(HUDLastTime)
                } else {
                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                }
            })
        }.disposed(by: disposeBag)
        //  下一步
        registerView.nextButton.rx.tap.subscribe { [weak self] _ in
            self?.view.endEditing(true)
            self?.viewModel.validateCode { (error) in
                if error == LYRequestError.success {
                    //  会员注册和多店注册
                    if self?.registerView.type == .member {
                        let vc = LYRegisterInfoController()
                        vc.viewModel.account.phone = self?.viewModel.phone?.int
                        self?.navigationController?.pushViewController(vc)
                    } else {
                        let vc = LYMultiRegisterInfoController()
                        vc.viewModel.account.phone = self?.viewModel.phone?.int
                        self?.navigationController?.pushViewController(vc)
                    }
                } else {
                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                }
            }
        }.disposed(by: disposeBag)
        //  注册
        registerView.protocalButton.rx.tap.subscribe { [weak self] _ in
            let vc = LYRegisterProtocalController()
            vc.type = self?.registerView.type ?? .member
            self?.navigationController?.pushViewController(vc)
        }.disposed(by: disposeBag)
    }
    
}

//  MARK: - UI
class LYRegisterController: BaseViewController {
    
    let viewModel = LYRegisterViewModel()
    let registerView = LYRegisterView.loadFromNib(named: "\(LYRegisterView.self)") as! LYRegisterView
    var type: LYRegisterType = .member {
        didSet {
            switch type {
            case .member:
                isMainColorNavigationBar = true
            case .shop:
                isMainColorNavigationBar = false
            }
        }
    }
    
    override func initSubViews() {
        view.addSubview(registerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

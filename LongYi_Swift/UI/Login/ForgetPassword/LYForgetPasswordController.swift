//
//  LYForgetPasswordController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/3.
//

import UIKit

extension LYForgetPasswordController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubViews()
        bind()
        UIActions()
    }
    
    override func bind() {
        forgetView.nameTF.rx.text.orEmpty.bind(to: viewModel.rx.name).disposed(by: disposeBag)
        forgetView.phoneTF.rx.text.orEmpty.bind(to: viewModel.rx.phone).disposed(by: disposeBag)
        forgetView.codeTF.rx.text.orEmpty.bind(to: viewModel.rx.code).disposed(by: disposeBag)
    }
    
    override func UIActions() {
        forgetView.codeButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel.sendCode({ (error) in
                if error == LYRequestError.success {
                    HUD.show(.success("已发送")).hide(HUDLastTime)
                } else {
                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                }
            })
        }).disposed(by: disposeBag)
        
        forgetView.nextButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel.validCode({ (error) in
                if error == LYRequestError.success {
                    let vc = LYForgetPasswordSetController()
                    vc.viewModel = self?.viewModel
                    self?.navigationController?.pushViewController(vc)
                } else {
                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                }
            })
        }).disposed(by: disposeBag)
    }

    
}

class LYForgetPasswordController: BaseViewController {
    
    let viewModel = LYForgetPasswordViewModel()
    let forgetView = LYForgetPasswordView.loadFromNib(named: "\(LYForgetPasswordView.self)") as! LYForgetPasswordView
        
    override func initSubViews() {
        title = "忘记密码"
        isMainColorNavigationBar = true
        view.addSubview(forgetView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        forgetView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

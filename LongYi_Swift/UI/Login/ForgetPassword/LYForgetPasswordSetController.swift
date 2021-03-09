//
//  LYForgetPasswordSetController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/3.
//

import UIKit

extension LYForgetPasswordSetController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
        bind()
        UIActions()
    }
    
    override func bind() {
        passwordSetView.passwordTF.rx.text.orEmpty.bind(to: viewModel.rx.password).disposed(by: disposeBag)
        passwordSetView.confirmTF.rx.text.orEmpty.bind(to: viewModel.rx.confirmword).disposed(by: disposeBag)
    }
    
    override func UIActions() {
        passwordSetView.resetButton.rx.tap.subscribe(onNext: { [weak self] _ in
            HUD.show(.loading())
            self?.viewModel.resetPassword({ (error) in
                if error == LYRequestError.success {
                    HUD.hide()
                    let vc = LYForgetPasswordSuccessController()
                    vc.viewModel = self?.viewModel
                    self?.navigationController?.pushViewController(vc)
                } else {
                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                }
            })
        }).disposed(by: disposeBag)
    }
    
}

//  MARK: - UI
class LYForgetPasswordSetController: BaseViewController {
    
    var viewModel: LYForgetPasswordViewModel!
    let passwordSetView = LYForgetPasswordSetView.loadFromNib(named: "\(LYForgetPasswordSetView.self)") as! LYForgetPasswordSetView
    
    override func initSubViews() {
        title = "忘记密码"
        isMainColorNavigationBar = true
        view.addSubview(passwordSetView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        passwordSetView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

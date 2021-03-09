//
//  LYForgetPasswordSuccessController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/3.
//

import UIKit

extension LYForgetPasswordSuccessController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubViews()
        UIActions()
    }
    
    override func UIActions() {
        successView.loginButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
}

class LYForgetPasswordSuccessController: BaseViewController {
    
    var viewModel: LYForgetPasswordViewModel!
    let successView = LYForgetPasswordSuccessView.loadFromNib(named: "\(LYForgetPasswordSuccessView.self)") as! LYForgetPasswordSuccessView

    override func initSubViews() {
        title = "忘记密码"
        isMainColorNavigationBar = true
        view.addSubview(successView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        successView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

//
//  LYMultiRegisterSuccessController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/2.
//

import UIKit

extension LYMultiRegisterSuccessController {
    
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
        
        header.switchButton.rx.tap.subscribe { [weak self] _ in
            let isShow = self?.viewModel.isShow ?? false
            self?.viewModel.isShow = !isShow
            self?.tableView.reloadData()
            self?.header.switchButton.isSelected = isShow
        }.disposed(by: disposeBag)
        
        footer.loginButton.rx.tap.subscribe { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }.disposed(by: disposeBag)
        
        footer.bindButton.rx.tap.subscribe { [weak self] _ in
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
    
    func refreshUI() {
        guard let model = viewModel.accountList?.first else { return }
        header.phoneLabel.text = model.phone
        header.nameLabel.text = model.username
    }

}

extension LYMultiRegisterSuccessController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isShow {
            return viewModel.accountList?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LYMultiRegisterSuccessCell.self, for: indexPath)
        let model = viewModel.accountList?[indexPath.row]
        cell.model = model
        return cell
    }
}

//  MARK: - UI
class LYMultiRegisterSuccessController: BaseViewController {
    
    let viewModel = LYMultiRegisterSuccessViewModel()
    let header = LYMultiRegisterHeaderView.loadFromNib(named: "\(LYMultiRegisterHeaderView.self)") as! LYMultiRegisterHeaderView
    let footer = LYMultiRegisterFooterView.loadFromNib(named: "\(LYMultiRegisterFooterView.self)") as! LYMultiRegisterFooterView
    var tableView = UITableView(frame: CGRect.zero, style: .plain)

    override func initSubViews() {
        isMainColorNavigationBar = false
        title = "多店会员注册完成"
        footer.bindButton.isHidden = true
        
        view.addSubview(tableView)
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(nib: UINib(nibName: "\(LYMultiRegisterSuccessCell.self)", bundle: nil), withCellClass: LYMultiRegisterSuccessCell.self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

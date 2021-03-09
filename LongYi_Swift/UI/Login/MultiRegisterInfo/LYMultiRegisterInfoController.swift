//
//  LYMultiRegisterInfoController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/1.
//

import UIKit

extension LYMultiRegisterInfoController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
        bind()
        UIActions()
        loadData()
    }
    
    override func bind() {
        viewModel.clientListRelay.subscribe(onNext: { [weak self] datas in
            self?.registerView.clientListData = datas
            self?.registerView.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    override func UIActions() {
        registerView.regionTF.rx.tapGesture().skip(1).subscribe { [weak self] _ in
            self?.view.endEditing(true)
            self?.openCityPicker()
        }.disposed(by: disposeBag)
        
        registerView.confirmButton.rx.tap.subscribe { [weak self] _ in
            self?.clickConfirmButton()
        }.disposed(by: disposeBag)

        registerView.nextButton.rx.tap.subscribe { [weak self] _ in
            self?.clickNextButton()
        }.disposed(by: disposeBag)
        
    }
    
    override func loadData() {
        HUD.show(.loading())
        viewModel.getClientList { (error) in
            if error == LYRequestError.success {
                HUD.hide()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }
    
    func clickNextButton() {
        if viewModel.isAddAccount {
            let vc = LYMultiRegisterSuccessController()
            vc.viewModel.accountList = viewModel.clientListRelay.value
            navigationController?.pushViewController(vc)
        } else {
            HUD.show(.error("请先添加一个会员信息")).hide(HUDLastTime)
        }
    }
    
    func clickConfirmButton() {
        //  phone在push前已传入,region选择地区已传入
        viewModel.account.rank = registerView.selectTag
        viewModel.account.username = registerView.nameTF.text
        viewModel.account.password = registerView.passwordTF.text
        viewModel.account.password_confirmation = registerView.confirmTF.text
        viewModel.account.email = registerView.mailTF.text
        viewModel.account.company = registerView.companyTF.text
        viewModel.account.contact_name = registerView.contactNameTF.text
        viewModel.account.contact_phone = registerView.contactPhoneTF.text
        
        HUD.show(.loading())
        viewModel.registerAccount { [weak self] (error) in
            if error == LYRequestError.success {
                HUD.show(.success("添加会员信息成功")).hide(HUDLastTime)
                self?.resetUI()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }
    
    /// 重置UI和model,重新发送列表请求
    func resetUI() {
        registerView.selectTag = 1
        registerView.nameTF.text = ""
        registerView.passwordTF.text = ""
        registerView.confirmTF.text = ""
        registerView.mailTF.text = ""
        registerView.companyTF.text = ""
        registerView.contactNameTF.text = ""
        registerView.contactPhoneTF.text = ""
        registerView.regionTF.text = ""
        
        let phone = viewModel.account.phone
        viewModel.account = LYAccountModel()
        viewModel.account.phone = phone
        viewModel.getClientList(nil)
    }
    
    func openCityPicker() {
        let cityPicker = YXChooseView(frame: CGRect(x: 0, y: view.height, width: view.width, height: 400))
        var stringCity = ""
        cityPicker.chooseCityNameAndCode = { [weak self] (titleArray, code) in
            titleArray.forEach { (item) in
                stringCity = stringCity + item
            }
            self?.registerView.regionTF.text = stringCity
            self?.viewModel.account.district = code.int
        }
        
        //  省和市的code
        cityPicker.chooseCityCodeArray = { [weak self] codeArray in
            self?.viewModel.account.province = codeArray.first?.int
            self?.viewModel.account.city = codeArray.last?.int
        }
    }
}

//  MARK: - UI
class LYMultiRegisterInfoController: BaseViewController {

    let viewModel = LYMultiRegisterInfoViewModel()
    let registerView = LYMultiRegisterInfoView.loadFromNib(named: "\(LYMultiRegisterInfoView.self)") as! LYMultiRegisterInfoView

    override func initSubViews() {
        isMainColorNavigationBar = false
        title = "填写多店会员账号信息"
        view.addSubview(registerView)
        registerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

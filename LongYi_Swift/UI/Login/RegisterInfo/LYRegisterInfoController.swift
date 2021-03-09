//
//  LYRegisterInfoController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/29.
//

import UIKit

class LYRegisterInfoController: BaseViewController {
    
    let viewModel = LYRegisterInfoViewModel()
    let registerView = LYRegisterInfoView.loadFromNib(named: "\(LYRegisterInfoView.self)") as! LYRegisterInfoView

    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
        UIActions()
    }
    
    override func initSubViews() {
        isMainColorNavigationBar = true
        title = "填写会员账号信息"
        view.addSubview(registerView)
        registerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func UIActions() {
        registerView.regionTF.rx.tapGesture().skip(1).subscribe { [weak self] _ in
            self?.view.endEditing(true)
            self?.openCityPicker()
        }.disposed(by: disposeBag)
        
        registerView.nextButton.rx.tap.subscribe { [weak self] _ in
            self?.clickNextButton()
        }.disposed(by: disposeBag)
    }
    
    func clickNextButton() {
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
                HUD.hide()
                let vc = LYRegisterSuccessController()
                vc.viewModel.account = self?.viewModel.account
                self?.navigationController?.pushViewController(vc)
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
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

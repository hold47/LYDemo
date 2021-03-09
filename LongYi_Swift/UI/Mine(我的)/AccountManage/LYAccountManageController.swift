//
//  LYAccountManageController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/4.
//

import UIKit

extension LYAccountManageController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "账号管理"
        bind()
    }
    
    override func bind() {
        
        UserPreference.shared.userRelay.subscribe { [weak self] _ in
            self?.refreshUI()
        }.disposed(by: disposeBag)
        
    }
    
    func logout() {
        showAlert(title: nil, message: "确定退出?", buttonTitles: ["取消", "确定"], highlightedButtonIndex: nil, completion: { [weak self] (index) in
            if index == 1 {
                HUD.show(.loading())
                self?.viewModel.logout { (error) in
                    if error == LYRequestError.success {
                        HUD.hide()
                        UserPreference.shared.logout()
                        self?.navigationController?.popToRootViewController(animated: false)
                        LYTabBarController.shared.selectedIndex = 0
                    } else {
                        HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                    }
                }
            }
        })
    }
    
    func refreshUI() {
        let model = UserPreference.shared.userRelay.value
        nameLabel.text = model?.username
        companyLabel.text = model?.ywy_group_name
        phoneLabel.text = model?.phone
    }
    
}

//  MARK: - UI
class LYAccountManageController: BaseViewController {
    
    let viewModel = LYAccountManageViewModel()

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = ""
        }
    }
    @IBOutlet weak var companyLabel: UILabel! {
        didSet {
            companyLabel.text = ""
        }
    }
    @IBOutlet weak var phoneLabel: UILabel! {
        didSet {
            phoneLabel.text = ""
        }
    }
    @IBOutlet weak var modifyPasswordView: UIView! {
        didSet {
            modifyPasswordView.rx.tapGesture().skip(1).subscribe { [weak self] (_) in
                self?.navigationController?.pushViewController(LYMineModifyPasswordController())
            }.disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.cornerRadius = logoutButton.height * 0.5
            logoutButton.rx.tap.subscribe { [weak self] (_) in
                self?.logout()
            }.disposed(by: disposeBag)
        }
    }

}

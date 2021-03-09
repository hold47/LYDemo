//
//  LYMineModifyPasswordController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/9/28.
//

import UIKit

extension LYMineModifyPasswordController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改密码"
        bind()
    }
    
    override func bind() {
        oldPasswordTF.rx.text.orEmpty.bind(to: viewModel.rx.oldPassword).disposed(by: disposeBag)
        newPasswordTF.rx.text.orEmpty.bind(to: viewModel.rx.password).disposed(by: disposeBag)
        confirmPasswordTF.rx.text.orEmpty.bind(to: viewModel.rx.confirmPassword).disposed(by: disposeBag)
    }

    private func modifyPassword() {
        HUD.show(.loading())
        viewModel.modifyPassword { [weak self] (error) in
            if error == LYRequestError.success {
                HUD.show(.success("修改成功")).hide(HUDLastTime)
                self?.navigationController?.popToRootViewController(animated: false)
                DispatchQueue.main.asyncAfter(deadline: .now() + HUDLastTime) {
                    UserPreference.shared.logout()
                }
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }
    
}

//  MARK: - UI
class LYMineModifyPasswordController: BaseViewController {
    
    let viewModel = LYMineModifyPasswordViewModel()
    
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var doneButton: UIButton! {
        didSet {
            doneButton.cornerRadius = doneButton.height * 0.5
            doneButton.rx.tap.subscribe { [weak self] (_) in
                self?.modifyPassword()
            }.disposed(by: disposeBag)
        }
    }

}

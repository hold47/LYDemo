//
//  LYLoginView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/2.
//

import UIKit

enum LYLoginType {
    /// 账号登录
    case account
    /// 手机登录
    case phone
}

extension LYLoginView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        type = .account
        bind()
        UIActions()
    }
    
    func bind() {
        //  accountLogin
        let nameValid = nameTF.rx.text.map{ $0?.count ?? 0 > 0 }.share()
        let passwordValid = passwordTF.rx.text.map{ $0?.count ?? 0 > 0}.share()
        let accountLoginValid = Observable.combineLatest(nameValid, passwordValid){ $0 && $1 }.share()
        accountLoginValid.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        accountLoginValid.subscribe(onNext: { [weak self] isEnable in
            self?.loginButton.isEnabled = isEnable
            if isEnable {
                self?.loginButton.backgroundColor = Constant.mainColor
            } else {
                self?.loginButton.backgroundColor = .lightGray
            }
        }).disposed(by: disposeBag)
        
        //  phoneLogin
        let phoneValid = phoneTF.rx.text.map{ $0?.count == 11 }.share()
        let codeValid = codeTF.rx.text.map{ $0?.count == 4}.share()
        let phoneLoginValid = Observable.combineLatest(phoneValid, codeValid){ $0 && $1 }.share()
        phoneValid.bind(to: codeButton.rx.isEnabled).disposed(by: disposeBag)
        phoneLoginValid.subscribe(onNext: { [weak self] isEnable in
            if isEnable {
                self?.loginButton.backgroundColor = Constant.mainColor
                self?.loginButton.isEnabled = true
            } else {
                self?.loginButton.backgroundColor = .lightGray
                self?.loginButton.isEnabled = false
            }
        }).disposed(by: disposeBag)
    }
    
    override func UIActions() {
        accountLoginButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.type = .account
        }).disposed(by: disposeBag)
        
        phoneLoginButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.type = .phone
        }).disposed(by: disposeBag)
        
        codeButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.codeButton.startCount()
        }).disposed(by: disposeBag)
    }
}

/// 按钮倒计时信息
fileprivate let totalCount = 60
extension LYLoginView: CountDelegate {
    
    func countButtonDidCount(_ button: UIButton, count: Int) {
        if count >= totalCount {
            button.isEnabled = true
            button.stopCount()
            button.setTitle("重新获取", for: .normal)
        } else {
            button.isEnabled = false
            button.setTitle("重发(\(totalCount - count)s)", for: .normal)
        }
    }
    
}

//  MARK: - UI
class LYLoginView: UIView {
    
    var disposeBag = DisposeBag()
    
    var type: LYLoginType = .account {
        didSet {
            switch type {
            case .account:
                accountLoginButton.titleColorForNormal = Constant.mainColor
                line1.backgroundColor = Constant.mainColor
                phoneLoginButton.titleColorForNormal = UIColor(hexString: "#666666")
                line2.backgroundColor = UIColor(hexString: "#E3E3E3")
                loginButton.backgroundColor = .lightGray
                accountView.isHidden = false
                phoneView.isHidden = true
                phoneTF.text = ""
                phoneTF.insertText("")
                codeTF.text = ""
                codeTF.insertText("")
                loginButton.isEnabled = false
            case .phone:
                accountLoginButton.titleColorForNormal = UIColor(hexString: "#666666")
                line1.backgroundColor = UIColor(hexString: "#E3E3E3")
                phoneLoginButton.titleColorForNormal = Constant.mainColor
                line2.backgroundColor = Constant.mainColor
                loginButton.backgroundColor = .lightGray
                accountView.isHidden = true
                phoneView.isHidden = false
                nameTF.text = ""
                nameTF.insertText("")
                passwordTF.text = ""
                passwordTF.insertText("")
                loginButton.isEnabled = false
                codeButton.isEnabled = false
            }
        }
    }

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var accountLoginButton: UIButton!
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var phoneLoginButton: UIButton!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var codeButton: UIButton! {
        didSet {
            codeButton.countDelegate = self
            codeButton.titleColorForNormal = Constant.mainColor
            codeButton.titleColorForDisabled = UIColor(hexString: "#999999")
        }
    }
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.cornerRadius = loginButton.height * 0.5
        }
    }
    @IBOutlet weak var protocalButton: UIButton!
    @IBOutlet weak var wechatButton: UIButton! {
        didSet {
            wechatButton.layoutImage(type: .top, space: 5)
        }
    }
    
}

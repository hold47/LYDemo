//
//  LYRegisterView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/26.
//

import UIKit

enum LYRegisterType {
    /// 会员注册
    case member
    /// 多店注册
    case shop
}

extension LYRegisterView {
    
    private func bind() {
        let phoneValid = phoneTextField.rx.text.map{ $0?.count == 11 }.share()
        let codeValid = codeTextField.rx.text.map{ $0?.count == 4}.share()
        let everythingValid = Observable.combineLatest(phoneValid, codeValid){ $0 && $1 }.share()
        
        phoneValid.bind(to: sendCodeButton.rx.isEnabled).disposed(by: disposeBag)
        everythingValid.subscribe(onNext: { [weak self] isEnable in
            self?.nextButton.isEnabled = isEnable
            if isEnable {
                if self?.type == .member {
                    self?.nextButton.backgroundColor = Constant.mainColor
                } else {
                    self?.nextButton.backgroundColor = self?.shopBlue
                }
            } else {
                self?.nextButton.backgroundColor = .lightGray
            }
        }).disposed(by: disposeBag)
        
        phoneTextField.rx.text.orEmpty.map { $0.count == 11 }.bind(to: nextButton.rx.isEnabled).disposed(by: disposeBag)
    }
    
    private func UIAction() {
        
        memberRegisterButton.rx.tap.subscribe { [weak self] _ in
            self?.type = .member
        }.disposed(by: disposeBag)
        
        shopRegisterButton.rx.tap.subscribe { [weak self] _ in
            self?.type = .shop
        }.disposed(by: disposeBag)
        
        sendCodeButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.sendCodeButton.startCount()
        }).disposed(by: disposeBag)
        
        //  限制电话号码长度
//        phoneTextField.rx.text.orEmpty.subscribe(onNext: { [unowned self] (text) in
//            if text.utf16.count > 11 {
//                self.phoneTextField.text = (text as NSString).substring(to: 11)
//            }
//        }).disposed(by: disposeBag)
        
    }
    
}

/// 按钮倒计时信息
fileprivate let totalCount = 60
extension LYRegisterView: CountDelegate {
    
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
class LYRegisterView: UIView {
    
    let disposeBag = DisposeBag()
    
    var type: LYRegisterType = .member {
        didSet {
            switch type {
            case .member:
                memberRegisterButton.titleColorForNormal = Constant.mainColor
                line1.backgroundColor = Constant.mainColor
                shopRegisterButton.titleColorForNormal = UIColor(hexString: "#666666")
                line2.backgroundColor = UIColor(hexString: "#E3E3E3")
                sendCodeButton.titleColorForNormal = Constant.mainColor
                nextButton.backgroundColor = .lightGray
                
                let attri = NSMutableAttributedString(string: "注册即表示用户协议")
                attri.addAttribute(.foregroundColor, value: Constant.mainColor, range: NSRange(location: 5, length: 4))
                protocalLabel.attributedText = attri
                
            case .shop:
                memberRegisterButton.titleColorForNormal = UIColor(hexString: "#666666")
                line1.backgroundColor = UIColor(hexString: "#E3E3E3")
                shopRegisterButton.titleColorForNormal = shopBlue
                line2.backgroundColor = shopBlue
                sendCodeButton.titleColorForNormal = shopBlue
                nextButton.backgroundColor = .lightGray
                let attri = NSMutableAttributedString(string: "注册即表示用户协议")
                attri.addAttribute(.foregroundColor, value: shopBlue!, range: NSRange(location: 5, length: 4))
                protocalLabel.attributedText = attri
            }
        }
    }
    
    @IBOutlet weak var memberRegisterButton: UIButton!
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var shopRegisterButton: UIButton!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var sendCodeButton: UIButton! {
        didSet {
            sendCodeButton.countDelegate = self
            sendCodeButton.titleColorForNormal = Constant.mainColor
            sendCodeButton.titleColorForDisabled = UIColor(hexString: "#999999")
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.cornerRadius = nextButton.height * 0.5
        }
    }
    @IBOutlet weak var protocalLabel: UILabel!
    @IBOutlet weak var protocalButton: UIButton!
    let shopBlue = UIColor(hexString: "#22A7F0")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        type = .member
        bind()
        UIAction()
    }

}

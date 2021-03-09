//
//  LYForgetPasswordView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/3.
//

import UIKit

extension LYForgetPasswordView {
    override func awakeFromNib() {
        super.awakeFromNib()
        bind()
        UIActions()
    }
    
    func bind() {
        let nameValid = nameTF.rx.text.map { $0?.count ?? 0 > 0 }.share()
        let phoneValid = phoneTF.rx.text.map { $0?.count == 11 }.share()
        let codeValid = codeTF.rx.text.map { $0?.count == 4 }.share()
        let allValid = Observable.combineLatest(nameValid, phoneValid, codeValid){ $0 && $1 && $2 }.share()
        phoneValid.bind(to: codeButton.rx.isEnabled).disposed(by: disposeBag)
        allValid.subscribe(onNext: { [weak self] isEnable in
            self?.nextButton.isEnabled = isEnable
            if isEnable {
                self?.nextButton.backgroundColor = Constant.mainColor
            } else {
                self?.nextButton.backgroundColor = .lightGray
            }
        }).disposed(by: disposeBag)
    }
    
    override func UIActions() {
        codeButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.codeButton.startCount()
        }).disposed(by: disposeBag)
    }
}

//  MARK: - UI
class LYForgetPasswordView: UIView {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var codeButton: UIButton! {
        didSet {
            codeButton.countDelegate = self
            codeButton.titleColorForNormal = Constant.mainColor
            codeButton.titleColorForDisabled = UIColor(hexString: "#999999")
            codeButton.isEnabled = false
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.cornerRadius = nextButton.height * 0.5
        }
    }
    
}

/// 按钮倒计时信息
fileprivate let totalCount = 60
extension LYForgetPasswordView: CountDelegate {
    
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

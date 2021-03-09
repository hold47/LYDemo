//
//  LYAddMinusView.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/6.
//

import UIKit

class LYAddMinusView: UIView {
    
    var addButton: UIButton!
    var minusButton: UIButton!
    var textField: UITextField!
    
    /// 加减系数  一般是中包装
    var baseCount: Int = 1
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
        bind()
        handleActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
        bind()
        handleActions()
    }
    
    override func initSubviews() {
        minusButton = UIButton(text: "-", textColor: .darkText, font: UIFont.systemFont(ofSize: 20))
        addSubview(minusButton)
        
        addButton = UIButton(text: "+", textColor: .darkText, font: UIFont.systemFont(ofSize: 20))
        addSubview(addButton)
        
        textField = UITextField()
        textField.isUserInteractionEnabled = true
        textField.cornerRadius = 3
        textField.text = "1"
        textField.borderStyle = .none
        textField.textAlignment = .center
        textField.keyboardType = .phonePad
        textField.font = UIFont.boldSystemFont(ofSize: 13)
        textField.textColor = .black
        addSubview(textField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        minusButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30)).priority(.medium)
            make.centerY.equalToSuperview()
            make.left.equalTo(3)
        }
        
        addButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30)).priority(.medium)
            make.centerY.equalToSuperview()
            make.right.equalTo(-3)
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(minusButton.snp.right)
            make.right.equalTo(addButton.snp.left)
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 25)).priority(.high)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func bind() {
        //  如果输入的不是中包装的整数倍,那么向上取余改成整数倍
        textField.rx.controlEvent(.editingDidEnd).subscribe(onNext: { [weak self] _ in
            guard let count = self?.textField.text?.float(), let baseCount = self?.baseCount else { return }
            let mo = count.int % baseCount
            if mo != 0 {
                let yu = ceil(count / (baseCount.float)) * baseCount.float
                self?.textField.text = yu.int.string
            }
        }).disposed(by: disposeBag)
    }
    
    func handleActions() {
        
        minusButton.rx.tap.subscribe { [weak self] (_) in
            self?.minusAction()
        }.disposed(by: disposeBag)
        
        addButton.rx.tap.subscribe { [weak self] (_) in
            self?.addAction()
        }.disposed(by: disposeBag)
    }
    
    func minusAction() {
        guard var result = textField.text?.int else { return }
        result -= baseCount
        
        if result <= 0 {
            result = baseCount
            shakeAction()
        } else {
            textField.text = result.string
        }
    }
    
    func addAction() {
        guard var result = textField.text?.int else { return }
            result += baseCount
        textField.text = result.string
    }

    func shakeAction() {
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        let x = layer.position.x
        animation.values = [(x-5), x, (x+5)]
        animation.repeatCount = 3
        animation.duration = 0.07
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
    }

}

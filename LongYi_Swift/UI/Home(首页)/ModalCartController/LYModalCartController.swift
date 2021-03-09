//
//  LYModalCartController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/9.
//

import UIKit

extension LYModalCartController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cartView)
        UIActions()
    }
    
    func UIActions() {
        cartView.confirmButton.rx.tap.subscribe { [weak self] _ in
            self?.addCart()
        }.disposed(by: disposeBag)
    }
    
    func addCart() {
        let model = cartView.model
        let param = LYAddCartParameterModel(goods_id: model?.id, price: model?.price, number: cartView.addMinusView.textField.text?.int, ck_id: model?.ck_id)
        HUD.show(.loading())
        viewModel.addCart(params: [param]) { [weak self] (error) in
            if error == LYRequestError.success {
                HUD.show(.success("成功加入购物车")).hide(HUDLastTime)
                self?.dismiss(animated: true, completion: nil)
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }
    
}

//  MARK: - UI
class LYModalCartController: YSModal_presentedVC {
    
    var cartView = LYModalCartView.loadFromNib(named: "\(LYModalCartView.self)") as! LYModalCartView
    let viewModel = LYModalCartViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.cornerRadius = 8
        cartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    //  设置modal的maskView
    override func ys_setupMaskView() -> (bgC: UIColor, alpha: CGFloat) {
        return (.black, 0.4)
    }
    
    //  设置modal的方向和宽高
    override func ys_setupDirectionAndLength() -> (direction: YSModal_direction, length: CGFloat) {
        return (.toTop, 340 + Constant.safeArea.bottom)
    }

}

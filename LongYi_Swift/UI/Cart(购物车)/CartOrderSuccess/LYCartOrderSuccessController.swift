//
//  LYCartOrderSuccessController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/14.
//

import UIKit

extension LYCartOrderSuccessController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "支付完成"
        bind()
        refreshUI()
        UIActions()
    }
    
    override func bind() {
//        UserPreference.shared.currentClientRelay.subscribe(onNext: { [weak self] client in
//            self?.clientNameLabel.text = client?.company
//        }).disposed(by: disposeBag)
    }
    
    override func UIActions() {
        //  查看订单,跳转到订单待支付
        orderButton.rx.tap.subscribe { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: false)
            LYTabBarController.shared.selectedIndex = 1
            NotificationCenter.default.post(name: LYNotificationName.selectOrderController, object: nil, userInfo: ["index": 1])
        }.disposed(by: disposeBag)
        
        //  继续下单,跳转到首页
        continueButton.rx.tap.subscribe { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: false)
            LYTabBarController.shared.selectedIndex = 0
        }.disposed(by: disposeBag)
        
    }
    
    func refreshUI() {
        receiverNameLabel.text = cartModel?.address?.shr
        addressLabel.text = cartModel?.address?.address
        orderLabel.text = commitModel?.order_sn
        priceLabel.text = "¥\(cartModel?.total_amount ?? "")"
        priceLabel.RMBStyle(logoFont: UIFont.systemFont(ofSize: 14))
    }
    
}

//  MARK: - UI
class LYCartOrderSuccessController: BaseViewController {
    
    var commitModel: LYCartOrderCommitModel?
    var cartModel: LYCartCheckModel?
    
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton! {
        didSet {
            orderButton.cornerRadius = 18
        }
    }
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.cornerRadius = 18
        }
    }
}

//
//  LYMineController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/9/28.
//

import UIKit

extension LYMineController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showAlert(title: "确认要退出吗", message: nil, buttonTitles: ["取消", "退出"]) { (index) in
            if index == 1 {
                self.viewModel.logout { (error) in
                    if error == LYRequestError.success {
                        UserPreference.shared.logout()
                        HUD.show(.success("已退出")).hide(HUDLastTime)
                        LYTabBarController.shared.selectedIndex = 0
                    } else {
                        HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Constant.tableViewBgColor
        bind()
        UIActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        loadData()
    }
    
    override func bind() {
        UserPreference.shared.userRelay.subscribe { [weak self] _ in
            self?.refreshUserInfo()
        }.disposed(by: disposeBag)
        
        viewModel.orderHeaderRelay.skip(1).subscribe { [weak self] _ in
            self?.refreshOrderHeader()
        }.disposed(by: disposeBag)
    }
    
    override func UIActions() {
        
        prepayButton.rx.tap.subscribe { [weak self] _ in
            self?.postNoti(index: 1)
        }.disposed(by: disposeBag)
        
        payButton.rx.tap.subscribe { [weak self] _ in
            self?.postNoti(index: 2)
        }.disposed(by: disposeBag)
        
        deliverButton.rx.tap.subscribe { [weak self] _ in
            self?.postNoti(index: 3)
        }.disposed(by: disposeBag)
        
        cancelButton.rx.tap.subscribe { [weak self] _ in
            self?.postNoti(index: 4)
        }.disposed(by: disposeBag)
        
        moreButton.rx.tap.subscribe { [weak self] _ in
            self?.postNoti(index: 0)
        }.disposed(by: disposeBag)
        
    }
    
    override func loadData() {
//        viewModel.getUserInfo(nil)
        viewModel.getOrderHeader(nil)
    }
    
    func postNoti(index: Int) {
        LYTabBarController.shared.selectedIndex = 1
        NotificationCenter.default.post(name: LYNotificationName.selectOrderController, object: nil, userInfo: ["index": index])
    }
    
    func refreshUserInfo() {
        let userinfo = UserPreference.shared.userRelay.value
        nameLabel.text = userinfo?.name
        desLabel.text = userinfo?.ywy_group_name
    }
    
    func refreshOrderHeader() {
        let model = viewModel.orderHeaderRelay.value
        func set(_ count: Int?, _ label: UILabel) {
            if count ?? 0 > 0 {
                label.isHidden = false
                label.text = count?.string
            } else {
                label.isHidden = true
            }
        }
        
        set(model.need_to_pay, prepayCountLabel)
        set(model.need_to_rec, payCountLabel)
        set(model.finished, deliverCountLabel)
        set(model.deleted, cancelCountLabel)
    }
    
}

//  MARK: - UI
class LYMineController: BaseViewController {
    
    let viewModel = LYMineViewModel()
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var accountManageButton: UIButton! {
        didSet {
            accountManageButton.roundCorners([.topLeft, .bottomLeft], radius: accountManageButton.height/2)
            accountManageButton.rx.tap.subscribe { [weak self] _ in
                let vc = LYAccountManageController()
                self?.navigationController?.pushViewController(vc)
            }.disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var menuView: UIView! {
        didSet {
            menuView.cornerRadius = 8
        }
    }
    @IBOutlet weak var prepayButton: UIButton! {
        didSet {
            prepayButton.centerTextAndImage(imageAboveText: true, spacing: 12)
        }
    }
    @IBOutlet weak var prepayCountLabel: UILabel! {
        didSet {
            prepayCountLabel.cornerRadius = 8
        }
    }
    @IBOutlet weak var payButton: UIButton! {
        didSet {
            payButton.centerTextAndImage(imageAboveText: true, spacing: 12)
        }
    }
    @IBOutlet weak var payCountLabel: UILabel! {
        didSet {
            payCountLabel.cornerRadius = 8
        }
    }
    @IBOutlet weak var deliverButton: UIButton! {
        didSet {
            deliverButton.centerTextAndImage(imageAboveText: true, spacing: 12)
        }
    }
    @IBOutlet weak var deliverCountLabel: UILabel! {
        didSet {
            deliverCountLabel.cornerRadius = 8
        }
    }
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.centerTextAndImage(imageAboveText: true, spacing: 12)
        }
    }
    @IBOutlet weak var cancelCountLabel: UILabel! {
        didSet {
            cancelCountLabel.cornerRadius = 8
        }
    }
}

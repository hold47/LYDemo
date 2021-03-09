//
//  LYCartOrderConfirmController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/13.
//

import UIKit

extension LYCartOrderConfirmController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单确定"
        refreshUI()
        UIActions()
    }
    
    override func UIActions() {
        commitButton.rx.tap.subscribe { [weak self] _ in
            self?.commitCartOrder()
        }.disposed(by: disposeBag)
    }
    
    func commitCartOrder() {
//        let ids = viewModel.cartCheckData?.check_data?.compactMap { $0.id?.string }
//        guard let array = ids else { return }
//        let goodIds = String.arrayToString(array: array, seperator: ",")
//        let pay_id = viewModel.payType
//        let remarks = viewModel.comment
//
//        HUD.show(.loading())
//        viewModel.commitCart(ids: goodIds, pay_id: pay_id, remarks: remarks) { [weak self] (error) in
//            if error == LYRequestError.success {
//                HUD.hide()
//                let vc = LYCartOrderSuccessController()
//                vc.commitModel = self?.viewModel.commitOrderRelay.value
//                vc.cartModel = self?.viewModel.cartCheckData
//                self?.navigationController?.pushViewController(vc)
//            } else {
//                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
//            }
//        }
    }
    
    func refreshUI() {
        let model = viewModel.cartCheckData
        nameLabel.text = "\(model?.address?.shr ?? "")  \(model?.address?.phone ?? "")"
        addressLabel.text = model?.address?.address
        priceLabel.text = "合计: ¥ \(model?.total_amount ?? "")"
    }
    
}

extension LYCartOrderConfirmController: UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.cartCheckData?.check_data?.count ?? 0
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LYCartOrderConfirmCell.self)
//        let model = viewModel.cartCheckData?.check_data?[indexPath.row]
//        cell.model = model
        return cell
    }
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withClass: LYCartOrderConfirmFooter.self)
        guard let payment = viewModel.cartCheckData?.payment else { return footer }
        let titles = payment.compactMap { $0.name }
        footer.payView.rx.tapGesture().skip(1).subscribe { [weak self] _ in
            self?.showSheet(title: nil, message: "请选择支付方式", cancelTitle: "取消", otherBtnTitles: titles, action: { index in
                guard index >= 0 else { return }
                self?.viewModel.payType = payment[index].id
                footer.payTypeLabel.text = payment[index].name
            })
        }.disposed(by: footer.disposeBag)
        
        footer.wordTextView.rx.text.orEmpty.subscribe { [weak self] event in
            self?.viewModel.comment = event.element
        }.disposed(by: footer.disposeBag)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.margin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
}

class LYCartOrderConfirmController: BaseViewController {

    let viewModel = LYCartOrderConfirmViewModel()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.backgroundColor = .white
        }
    }
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(nib: UINib(nibName: "\(LYCartOrderConfirmCell.self)", bundle: nil), withCellClass: LYCartOrderConfirmCell.self)
            tableView.register(nib: UINib(nibName: "\(LYCartOrderConfirmFooter.self)", bundle: nil), withHeaderFooterViewClass: LYCartOrderConfirmFooter.self)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.backgroundColor = Constant.tableViewBgColor
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var commitButton: UIButton! {
        didSet {
            commitButton.cornerRadius = 16
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomViewHeight.constant = 50 + Constant.safeArea.bottom
    }
}

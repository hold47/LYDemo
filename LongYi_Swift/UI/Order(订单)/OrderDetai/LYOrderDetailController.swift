//
//  LYOrderDetailController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/7.
//

import UIKit

extension LYOrderDetailController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "订单详情"
        initSubViews()
        bind()
        loadData()
    }
    
    override func bind() {
        viewModel.orderDetailRelay.skip(1).subscribe { [weak self] (_) in
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    override func loadData() {
        HUD.show(.loading())
        viewModel.getOrderDetail { (error) in
            if error == LYRequestError.success {
                HUD.hide()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }
    
}

extension LYOrderDetailController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return viewModel.orderDetailRelay.value.order_goods?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LYOrderDetailGoodsListCell.self, for: indexPath)
        let model = viewModel.orderDetailRelay.value.order_goods?[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withClass: LYOrderDetaiInfoHeader.self)
        let model = viewModel.orderDetailRelay.value
        if section == 0 {
            header.titleLabel.text = "订单信息"
            header.stateLabel.isHidden = false
            header.stateLabel.text = model.order_status_label
        } else {
            header.titleLabel.text = "订单清单"
            header.stateLabel.isHidden = true
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withClass: LYOrderDetailInfoFooter.self)
        let model = viewModel.orderDetailRelay.value
        
        if section == 0 {
            footer.bgView.subviews.forEach({ $0.isHidden = false })
            footer.orderLabel.text = model.order_sn
            footer.timeLabel.text = model.created_at
        } else {
            footer.bgView.subviews.forEach({ $0.isHidden = true })
        }
        
        return footer
    }
        
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 80
        } else {
            return 55
        }
    }
        
}

//  MARK: - UI
class LYOrderDetailController: BaseViewController {
    
    let viewModel = LYOrderDetaiViewModel()
    var tableView: UITableView!

    override func initSubViews() {
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Constant.tableViewBgColor
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.register(nib: UINib(nibName: "\(LYOrderDetailGoodsListCell.self)", bundle: nil), withCellClass: LYOrderDetailGoodsListCell.self)
        tableView.register(nib: UINib(nibName: "\(LYOrderDetaiInfoHeader.self)", bundle: nil), withHeaderFooterViewClass: LYOrderDetaiInfoHeader.self)
        tableView.register(nib: UINib(nibName: "\(LYOrderDetailInfoFooter.self)", bundle: nil), withHeaderFooterViewClass: LYOrderDetailInfoFooter.self)
        tableView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

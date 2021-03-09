//
//  LYCartController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/11.
//

import UIKit

extension LYCartController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "购物车"
        view.backgroundColor = Constant.tableViewBgColor
        
        bind()
        UIActions()
        loadData()
    }
        
    override func bind() {
        
        
    }
    
    override func UIActions() {
        
        
        
    }
    
    override func loadData() {
//        tableView.tab_startAnimation {}
        viewModel.getCartList { (error) in
            if error == LYRequestError.success {
//                self?.tableView.tab_endAnimationEaseOut()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }
    
}

//extension LYCartController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.cartOrderRelay.value.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withClass: LYCartCell.self, for: indexPath)
//        let model = viewModel.cartOrderRelay.value[indexPath.row]
//        cell.model = model
//
//        //  点击选择框
//        cell.selectButton.rx.tap.subscribe { [weak self] _ in
//            model.isSelect = !(model.isSelect ?? false)
//            cell.model = model
//
//        }.disposed(by: cell.disposeBag)
//
//        //  添加商品
//        cell.addMinusView.addButton.rx.tap.subscribe { [weak self] _ in
//            self?.viewModel.editGoodsNumber(id: model.id ?? 0, number: cell.addMinusView.textField.text?.int ?? 0, { (error) in
//                if error == LYRequestError.success {
//                } else {
//                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
//                }
//            })
//        }.disposed(by: cell.disposeBag)
//
//        //  减少商品
//        cell.addMinusView.minusButton.rx.tap.subscribe { [weak self] _ in
//            self?.viewModel.editGoodsNumber(id: model.id ?? 0, number: cell.addMinusView.textField.text?.int ?? 0, { (error) in
//                if error == LYRequestError.success {
//                } else {
//                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
//                }
//            })
//        }.disposed(by: cell.disposeBag)
//
//        //  删除
//        cell.deleteButton.rx.tap.subscribe { [weak self] _ in
//            self?.showAlert(title: "确认要删除吗", message: nil, buttonTitles: ["取消", "确认"], highlightedButtonIndex: 1, completion: { index in
//                if index == 1 {
//                    self?.viewModel.deleteGoods(ids: model.id ?? 0) { (error) in
//                        if error == LYRequestError.success {
//                            HUD.show(.success("删除成功")).hide(HUDLastTime)
//                        } else {
//                            HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
//                        }
//                    }
//                }
//            })
//        }.disposed(by: cell.disposeBag)
//
//        //  点击图片
//        cell.icon.rx.tapGesture().skip(1).subscribe { [weak self] _ in
//            let vc = LYGoodsController()
//            vc.viewModel.goodsID = model.goods_id ?? 0
//            self?.navigationController?.pushViewController(vc)
//        }.disposed(by: cell.disposeBag)
//
//        return cell
//    }
//
//}

//  MARK: - UI
class LYCartController: BaseViewController {
    
    let viewModel = LYCartViewModel()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
}

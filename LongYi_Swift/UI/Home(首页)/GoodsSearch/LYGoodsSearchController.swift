//
//  LYGoodsSearchController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/3.
//

import UIKit

//extension LYGoodsSearchController {
//    
//}
//
////  MARK: - UI
//class LYGoodsSearchController: YNSearchViewController {
//    
//    var disposeBag = DisposeBag()
//    let viewModel = LYHomeViewModel()
//    
//    /// 自定义导航栏返回按钮
//    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
//        let button = UIButton(type: .custom)
//        button.imageForNormal = UIImage(named: "arrow_left_black")
//        button.sizeToFit()
//        button.addTarget(target, action: action, for: .touchUpInside)
//        return UIBarButtonItem(customView: button)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "搜索商品"
//        
////        let ynSearch = YNSearch()
////        guard let history = ynSearch.getSearchHistories() else { return }
////        ynSearch.setSearchHistories(value: history)
//        
//        self.ynSearchinit()
//        self.delegate = self
//        handleActions()
//    }
//}
//
//extension LYGoodsSearchController {
//    func handleActions() {
//        ynSearchTextfieldView.ynSearchTextField.rx.text.orEmpty.subscribe { [weak self] (text) in
//            guard text.element?.count ?? 0 > 0 else { return }
//            self?.viewModel.blurParam.keywords = text.element ?? ""
//            self?.getBlurSearch()
//        }.disposed(by: disposeBag)
//    }
//
//    func getBlurSearch() {
////        viewModel.getSearchGoods { [weak self] (error) in
////            if error == LYRequestError.success {
//////                self?.initData(database: self?.viewModel.goodsSearchData ?? [])
////            } else {
////                HUD.show(.error(error.description)).hide(delay: HUDLastTime)
////            }
////        }
//    }
//}
//
//extension LYGoodsSearchController: YNSearchDelegate {
//    func ynSearchListViewDidScroll() {
//        self.ynSearchTextfieldView.ynSearchTextField.endEditing(true)
//    }
//    
//
//    func ynSearchHistoryButtonClicked(text: String) {
//        self.pushViewController(text: text)
//        print(text)
//    }
//    
//    func ynCategoryButtonClicked(text: String) {
//        self.pushViewController(text: text)
//        print(text)
//    }
//    
//    func ynSearchListViewClicked(key: String) {
//        self.pushViewController(text: key)
//        print(key)
//    }
//    
//    func ynSearchListViewClicked(object: Any) {
//        print(object)
//    }
//    
//    func ynSearchListView(_ ynSearchListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.ynSearchView.ynSearchListView.dequeueReusableCell(withIdentifier: YNSearchListViewCell.ID) as! YNSearchListViewCell
//        if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel {
//            cell.searchLabel.text = ynmodel.key
//        }
//        
//        return cell
//    }
//    
//    func ynSearchListView(_ ynSearchListView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel, let key = ynmodel.key {
//            self.ynSearchView.ynSearchListView.ynSearchListViewDelegate?.ynSearchListViewClicked(key: key)
//            self.ynSearchView.ynSearchListView.ynSearchListViewDelegate?.ynSearchListViewClicked(object: self.ynSearchView.ynSearchListView.database[indexPath.row])
//            self.ynSearchView.ynSearchListView.ynSearch.appendSearchHistories(value: key)
//        }
//    }
//    
//    func pushViewController(text: String) {
//        
//        
//    }
//}


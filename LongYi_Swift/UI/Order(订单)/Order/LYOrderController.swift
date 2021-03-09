//
//  LYOrderController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/6.
//

import UIKit

extension LYOrderController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单"
        initSubViews()
        bind()
        UIActions()
        loadData()
    }

    override func bind() {
        
        //  将日期OB绑定在textfield和viewmodel上
        let startObservable = startDateView.datePicker.rx.date.skip(1).map { $0.string(withFormat: "yyyy-MM-dd") }
        startObservable.bind(to: selectView.startTF.rx.text).disposed(by: disposeBag)
        startObservable.bind(to: viewModel.rx.startTime).disposed(by: disposeBag)
        
        let endObservable = endDateView.datePicker.rx.date.skip(1).map { $0.string(withFormat: "yyyy-MM-dd") }
        endObservable.bind(to: selectView.endTF.rx.text).disposed(by: disposeBag)
        endObservable.bind(to: viewModel.rx.endTime).disposed(by: disposeBag)
        
        viewModel.orderRelay.skip(1).subscribe { [weak self] (_) in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    override func UIActions() {
        
        startDateView.cancelButton.rx.tap.subscribe { [weak self] _ in
            self?.selectView.startTF.resignFirstResponder()
        }.disposed(by: disposeBag)
        
        endDateView.cancelButton.rx.tap.subscribe { [weak self] _ in
            self?.selectView.endTF.resignFirstResponder()
        }.disposed(by: disposeBag)
        
        selectView.searchButton.rx.tap.subscribe { [weak self] _ in
            self?.loadData()
            self?.view.endEditing(true)
        }.disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(LYNotificationName.selectOrderController).subscribe(onNext: { [weak self] noti in
            let info = noti.userInfo as! [String: Int]
            let index = info["index"]
            self?.selectSegment(index: index!)
        }).disposed(by: disposeBag)

    }
    
    override func loadData() {
//        tableView.tab_startAnimation {}
        viewModel.getOrderList(isRefresh: true) { [weak self] (error, hasmore) in
            if error == LYRequestError.success {
//                self?.tableView.tab_endAnimationEaseOut()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
            if hasmore {
                self?.tableView.mj_footer?.isHidden = false
                self?.tableView.resetNoMoreData()
            } else {
                self?.tableView.mj_footer?.isHidden = true
            }
        }
    }
    
    override func loadmore() {
        viewModel.getOrderList(isRefresh: false) { [weak self] (error, hasmore) in
            self?.tableView.endRefreshing()
            if error != LYRequestError.success {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
            if !hasmore {
                self?.tableView.noMoreData()
            }
        }
    }
    
    func selectSegment(index: Int) {
        segmentView.selectItemAt(index: index)
    }
    
}

extension LYOrderController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LYOrderCell.self, for: indexPath)
        let model = viewModel.orderRelay.value[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.orderRelay.value[indexPath.row]
        let vc = LYOrderDetailController()
        vc.viewModel.orderID = model.id ?? 0
        navigationController?.pushViewController(vc)
    }
    
}

extension LYOrderController: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        viewModel.param.type = index
        loadData()
    }
    
}

//  MARK: - UI
class LYOrderController: BaseViewController {
    
    let viewModel = LYOrderViewModel()
    
    let titles = ["全部", "待付款", "已开票", "已完成", "已取消"]
    var segmentView: JXSegmentedView!
    var segmentDatasource: JXSegmentedTitleDataSource!
    var segmentIndicator: JXSegmentedIndicatorImageView!
    var selectView: LYOrderSelectSearchView!
    var tableView: UITableView!
    var startDateView: LYDatePickerView!
    var endDateView: LYDatePickerView!
        
    override func initSubViews() {
        
        //  segmentView
        segmentView = JXSegmentedView()
        segmentView.delegate = self
        view.addSubview(segmentView)
        segmentDatasource = JXSegmentedTitleDataSource()
        segmentDatasource.titles = titles
        segmentDatasource.titleSelectedColor = UIColor(hexString: "#333333")!
        segmentDatasource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 14)
        segmentDatasource.titleNormalColor = UIColor(hexString: "#333333")!
        segmentDatasource.titleNormalFont = UIFont.systemFont(ofSize: 14)
        segmentView.dataSource = segmentDatasource
        segmentIndicator = JXSegmentedIndicatorImageView()
        segmentIndicator.image = UIImage(named: "segment_select")
        segmentView.indicators = [segmentIndicator]
        
        //  selectView
        selectView = LYOrderSelectSearchView.loadFromNib(named: "\(LYOrderSelectSearchView.self)") as? LYOrderSelectSearchView
        view.addSubview(selectView)
                    
        startDateView = LYDatePickerView.loadFromNib(named: "\(LYDatePickerView.self)") as? LYDatePickerView
        endDateView = LYDatePickerView.loadFromNib(named: "\(LYDatePickerView.self)") as? LYDatePickerView
        selectView.startTF.inputView = startDateView
        selectView.endTF.inputView = endDateView
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(nib: UINib(nibName: "\(LYOrderCell.self)", bundle: nil), withCellClass: LYOrderCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Constant.tableViewBgColor
        tableView.keyboardDismissMode = .onDrag
        tableView.addFooter { [weak self] in
            self?.loadmore()
        }
        tableView.separatorStyle = .none
        addEmptyDataSet(tableView)
        tableView.mj_footer?.isHidden = true
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
//        tableView.tabAnimated = TABTableAnimated(cellClass: LYOrderCell.self, cellHeight: 155)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        selectView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(selectView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
}

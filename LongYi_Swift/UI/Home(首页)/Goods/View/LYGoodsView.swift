//
//  LYGoodsView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/30.
//

import UIKit

extension LYGoodsView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            guard let tags = model?.tags else { return 0 }
            let resultTags = tags.filter({ $0.is_show ?? 0 == 1 })
            return resultTags.count
        }
        
        if section == 2 {
            return model?.coupon_data?.count ?? 0
        }
                
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withClass: LYGoodsBannerCell.self, for: indexPath)
            cell.model = model
            cell.activityButton.rx.tap.subscribe { [weak self] _ in
                self?.actionClosure?("活动点击", 0)
            }.disposed(by: cell.disposeBag)
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withClass: LYGoodsTagCell.self, for: indexPath)
            guard let tags = model?.tags else { return cell }
            let resultTags = tags.filter({ $0.is_show ?? 0 == 1 })
            cell.model = resultTags[indexPath.item]
            return cell
        }
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withClass: LYGoodsQuanCell.self, for: indexPath)
            cell.model = model?.coupon_data?[indexPath.row]
            cell.quanButton.rx.tap.subscribe { [weak self] _ in
                if cell.quanButton.titleLabel?.text == "点击领券 >" {
                    self?.actionClosure?("点击领券", indexPath.row)
                } else {
                    self?.actionClosure?("点击查看", indexPath.row)
                }
            }.disposed(by: cell.disposeBag)
            return cell
        }
        
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withClass: LYGoodsGuigeCell.self, for: indexPath)
            cell.model = model
            return cell
        }
        
        //  section == 4
        let cell = tableView.dequeueReusableCell(withClass: LYGoodsTuijianCell.self, for: indexPath)
        cell.models = tuijianModels
        cell.actionClosure = { [weak self] (name, index) in
            self?.actionClosure?(name, index)
        }
        return cell
    }
    
}

class LYGoodsView: UIView {
    
    var actionClosure: ((String, Int) -> ())?
    var model: LYGoodsModel? {
        didSet {
            tableView.reloadData()
        }
    }
    var tuijianModels: [LYGoodsModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var tableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initSubviews() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hexString: "#F5F5F5")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(nibWithCellClass: LYGoodsBannerCell.self)
        tableView.register(nibWithCellClass: LYGoodsGuigeCell.self)
        tableView.register(nibWithCellClass: LYGoodsTagCell.self)
        tableView.register(nibWithCellClass: LYGoodsQuanCell.self)
        tableView.register(nibWithCellClass: LYGoodsTuijianCell.self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension LYGoodsView: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self
    }
}

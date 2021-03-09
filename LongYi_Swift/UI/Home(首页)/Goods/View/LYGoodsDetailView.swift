//
//  LYGoodsDetailView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/2.
//

import UIKit

extension LYGoodsDetailView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataSource?.count ?? 0
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LYGoodsDetailCell.self, for: indexPath)
        cell.titleLabel.text = titles[indexPath.row]
        cell.content = dataSource?[indexPath.row]
        return cell
    }
    
}

class LYGoodsDetailView: UIView {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.backgroundColor = UIColor(hexString: "#F5F5F5")
            tableView.register(nibWithCellClass: LYGoodsDetailCell.self)
        }
    }
    var dataSource: [String]? {
        didSet {
            tableView.reloadData()
        }
    }
    var titles = ["说明书", "配货说明"]

}

extension LYGoodsDetailView: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self
    }
}

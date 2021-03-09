//
//  LYModalQuanView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/3.
//

import UIKit

extension LYModalQuanView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LYModalQuanCell.self, for: indexPath)
        let m = model?.items?[indexPath.row]
        cell.model = m
        return cell
    }
    
}

class LYModalQuanView: UIView {

    var model: LYCouponModel? {
        didSet {
            countLabel.text = "可领取优惠券( \(model?.items?.count ?? 0) )张"
            let attri = NSMutableAttributedString(string: countLabel.text!)
            let range = NSRange(location: (attri.length - 1) - 2, length: 1)
            attri.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: range)
            attri.addAttribute(.foregroundColor, value: UIColor(hexString: "#333333")!, range: range)
            countLabel.attributedText = attri
            
            if model?.is_get ?? 0 == 1 {
                getButton.backgroundColor = UIColor(hexString: "#CDCDCD")
                getButton.isEnabled = false
                getButton.titleForNormal = "已领取"
            } else {
                getButton.backgroundColor = UIColor(hexString: "#22A7F0")
                getButton.isEnabled = true
                getButton.titleForNormal = "一键领取"
            }
        }
    }
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.register(nibWithCellClass: LYModalQuanCell.self)
        }
    }
    @IBOutlet weak var getButton: UIButton! {
        didSet {
            getButton.cornerRadius = getButton.height / 2
        }
    }

}

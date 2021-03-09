//
//  LYMultiRegisterInfoView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/1.
//

import UIKit

extension LYMultiRegisterInfoView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LYMultiRegisterInfoCell.self)", for: indexPath) as! LYMultiRegisterInfoCell
        let model = clientListData[indexPath.row]
        cell.model = model
        return cell
    }
    
}

extension LYMultiRegisterInfoView: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.tagViews.forEach{ $0.isSelected = false }
        tagView.isSelected = true
        switch title {
        case "药店":
            selectTag = 1
        case "诊所":
            selectTag = 2
        case "商业公司":
            selectTag = 3
        case "连锁公司":
            selectTag = 4
        case "加盟店":
            selectTag = 5
        default:
            break
        }
    }
}

//  MARK: - UI
class LYMultiRegisterInfoView: UIView {
    
    let disposeBag = DisposeBag()
    var clientListData = [LYAccountShopModel]()

    @IBOutlet weak var accountButton: UIButton! {
        didSet {
            accountButton.layoutImage(type: .right, space: 5)
        }
    }
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var contactNameTF: UITextField!
    @IBOutlet weak var contactPhoneTF: UITextField!
    @IBOutlet weak var regionTF: UITextField! {
        didSet {
            //  隐藏光标
            regionTF.tintColor = .clear
            regionTF.isUserInteractionEnabled = false
        }
    }
    @IBOutlet weak var confirmButton: UIButton! {
        didSet {
            confirmButton.cornerRadius = confirmButton.height * 0.5
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.backgroundColor = .white
            nextButton.borderColor = UIColor(hexString: "#22A7F0")
            nextButton.borderWidth = 1
            nextButton.cornerRadius = nextButton.height * 0.5
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.isHidden = true
            tableView.separatorStyle = .none
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            tableView.register(nib: UINib(nibName: "\(LYMultiRegisterInfoCell.self)", bundle: nil), withCellClass: LYMultiRegisterInfoCell.self)
        }
    }
    var selectTag = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initSubviews()
        UIActions()
    }
    
    override func initSubviews() {
        tagListView.addTags(["药店", "诊所", "商业公司", "连锁公司", "加盟店"])
        tagListView.textFont = UIFont.systemFont(ofSize: 14)
        tagListView.textColor = UIColor(hexString: "#666666")!
        tagListView.selectedTextColor = .white
        tagListView.tagSelectedBackgroundColor = UIColor(hexString: "#22A7F0")
        tagListView.tagBackgroundColor = UIColor(hexString: "#EEEEEE")!
        tagListView.alignment = .center
        tagListView.delegate = self
        tagListView.tagViews.forEach { (tag) in
            tag.layer.cornerRadius = 12
            tag.layer.masksToBounds = true
        }
        tagListView.tagViews.first?.isSelected = true
    }
        
    override func UIActions() {
        accountButton.rx.tap.subscribe { [weak self] _ in
            self?.tableView.isHidden = false
        }.disposed(by: disposeBag)
        
        tableView.rx.tapGesture().skip(1).subscribe { [weak self] _ in
            self?.tableView.isHidden = true
        }.disposed(by: disposeBag)
    }

}

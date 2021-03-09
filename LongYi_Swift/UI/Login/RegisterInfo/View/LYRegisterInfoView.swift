//
//  LYRegisterInfoView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/29.
//

import UIKit

extension LYRegisterInfoView: TagListViewDelegate {
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

class LYRegisterInfoView: UIView {
    
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
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.backgroundColor = Constant.mainColor
            nextButton.cornerRadius = nextButton.height * 0.5
        }
    }
    var selectTag = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagListView.addTags(["药店", "诊所", "商业公司", "连锁公司", "加盟店"])
        tagListView.textFont = UIFont.systemFont(ofSize: 14)
        tagListView.textColor = UIColor(hexString: "#666666")!
        tagListView.selectedTextColor = .white
        tagListView.tagSelectedBackgroundColor = Constant.mainColor
        tagListView.tagBackgroundColor = UIColor(hexString: "#EEEEEE")!
        tagListView.alignment = .center
        tagListView.delegate = self
        tagListView.tagViews.forEach { (tag) in
            tag.layer.cornerRadius = 12
            tag.layer.masksToBounds = true
        }
        tagListView.tagViews.first?.isSelected = true
        
    }

}

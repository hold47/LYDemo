//
//  LYSortController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/14.
//

import UIKit

extension LYSortController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubViews()
    }
    
}

class LYSortController: BaseViewController {
    
    let sortView = LYSortView.loadFromNib(named: "\(LYSortView.self)") as! LYSortView

    override func initSubViews() {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(sortView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sortView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

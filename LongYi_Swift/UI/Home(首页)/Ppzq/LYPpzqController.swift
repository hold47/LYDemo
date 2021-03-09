//
//  LYPpzqController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/25.
//

import UIKit

extension LYPpzqController {
    
    override func router(name: String, index: Int) {
        if name == "品牌点击" {
            
        }
        LYPrint(name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubViews()
        bind()
        loadData()
        UIActions()
    }
    
    override func bind() {
        viewModel.brandRelay.skip(1).subscribe(onNext: { [weak self] list in
            self?.ppzqView.dataSource = list
        }).disposed(by: disposeBag)
    }
    
    override func loadData() {
        HUD.show(.loading())
        viewModel.getBrandList { (error) in
            if error == LYRequestError.success {
                HUD.hide()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }
    
    override func UIActions() {
        ppzqView.actionsClosure = { [weak self] name, index in
            self?.router(name: name, index: index)
        }
    }
}

class LYPpzqController: BaseViewController {
    
    let ppzqView = LYPpzqView()
    let viewModel = LYPpzqViewModel()

    override func initSubViews() {
        title = "品牌专区"
        view.addSubview(ppzqView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ppzqView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

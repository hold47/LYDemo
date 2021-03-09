//
//  LYYxbpController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/25.
//

import UIKit

extension LYYxbpController {
    
    override func router(name: String, index: Int) {
        LYPrint(name)
        
        if name == "优选特推购物车" {
            guard let model = viewModel.yxbpAdRelay.value?.banner_down?.first?.goods?[index] else { return }
            presentCartView(model)
        }
        
        if name == "优选特价购物车" {
            let model = viewModel.tejiaRelay.value[index]
            presentCartView(model)
        }
        
        if name == "更多优选购物车" {
            let model = viewModel.moreRelay.value[index]
            presentCartView(model)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubViews()
        bind()
        loadData()
    }
    
    override func bind() {
        viewModel.yxbpAdRelay.skip(1).subscribe(onNext: { [weak self] model in
            self?.yxbpView.adModel = model
        }).disposed(by: disposeBag)
        
        viewModel.tejiaRelay.skip(1).subscribe(onNext: { [weak self] list in
            self?.yxbpView.tejiaModels = list
        }).disposed(by: disposeBag)
        
        viewModel.moreRelay.skip(1).subscribe(onNext: { [weak self] list in
            self?.yxbpView.moreModels = list
            if list.count > 0 {
                self?.yxbpView.collectionView.mj_footer?.isHidden = false
            }
        }).disposed(by: disposeBag)
    }
    
    override func loadData() {
        HUD.show(.loading())
        viewModel.getAd { (error) in
            if error == LYRequestError.success {
                HUD.hide()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
        
        viewModel.getYouxTejia(nil)
        viewModel.getMoreYoux(isRefresh: true, nil)
    }
    
    override func loadmore() {
        viewModel.getMoreYoux(isRefresh: false) { [weak self] (error, hasmore) in
            self?.yxbpView.collectionView.endRefreshing()
            if error != LYRequestError.success {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
            if !hasmore {
                self?.yxbpView.collectionView.noMoreData()
            }
        }
    }
    
    /// 购物车选择器
    func presentCartView(_ model: LYGoodsModel) {
        let vc = LYModalCartController()
        vc.cartView.model = model
        present(vc, animated: true, completion: nil)
    }

}

class LYYxbpController: BaseViewController {
    
    let yxbpView = LYYxbpView()
    let viewModel = LYYxbpViewModel()

    override func initSubViews() {
        title = "优选爆品"
        view.addSubview(yxbpView)
        yxbpView.collectionView.addFooter { [weak self] in
            self?.loadmore()
        }
        yxbpView.actionsClosure = { [weak self] name, index in
            self?.router(name: name, index: index)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        yxbpView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

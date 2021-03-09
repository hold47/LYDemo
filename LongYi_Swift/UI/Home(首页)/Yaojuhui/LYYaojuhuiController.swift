//
//  LYYaojuhuiController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/24.
//

import UIKit

extension LYYaojuhuiController {
    
    override func router(name: String, index: Int) {
        if name == "药聚会点击分类" {
            let naviModel = viewModel.yjhNaviRelay.value[index]
            viewModel.yjhId = naviModel.id ?? 0
            viewModel.yjhType = naviModel.type ?? 0
            
            self.refreshData()
        }
        
        if name == "药聚会购物车" {
            let model = viewModel.yjhGoodsRelay.value[index]
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
        viewModel.yjhNaviRelay.skip(1).subscribe(onNext: { [weak self] list in
            let first = list.first
            self?.viewModel.yjhId = first?.id ?? 0
            self?.viewModel.yjhType = first?.type ?? 0
            self?.yaojuhuiView.homeYjhNaviData = list
            self?.viewModel.getYjhGoods(isRefresh: true, { (_, hasmore) in
                if hasmore {
                    self?.yaojuhuiView.collectionView.resetNoMoreData()
                    self?.yaojuhuiView.collectionView.mj_footer?.isHidden = false
                } else {
                    self?.yaojuhuiView.collectionView.noMoreData()
                    self?.yaojuhuiView.collectionView.mj_footer?.isHidden = true
                }
            })
        }).disposed(by: disposeBag)
        
        viewModel.yjhGoodsRelay.skip(1).subscribe(onNext: { [weak self] list in
            self?.yaojuhuiView.homeYjhGoodsData = list
        }).disposed(by: disposeBag)
    }
    
    private func refreshData() {
        viewModel.getYjhGoods(isRefresh: true) { [weak self] (error, hasmore) in
            self?.yaojuhuiView.collectionView.endRefreshing()
            if error != LYRequestError.success {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
            if hasmore {
                self?.yaojuhuiView.collectionView.resetNoMoreData()
                self?.yaojuhuiView.collectionView.mj_footer?.isHidden = false
            } else {
                self?.yaojuhuiView.collectionView.noMoreData()
                self?.yaojuhuiView.collectionView.mj_footer?.isHidden = true
            }
        }
    }
    
    override func loadData() {
        HUD.show(.loading())
        viewModel.getYjhNavi { (error) in
            if error == LYRequestError.success {
                HUD.hide()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }
    
    override func loadmore() {
        viewModel.getYjhGoods(isRefresh: false) { [weak self] (error, hasmore) in
            self?.yaojuhuiView.collectionView.endRefreshing()
            if error != LYRequestError.success {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
            if !hasmore {
                self?.yaojuhuiView.collectionView.noMoreData()
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

class LYYaojuhuiController: BaseViewController {
    
    let yaojuhuiView = LYYaojuhuiView()
    let viewModel = LYYaojuhuiViewModel()

    override func initSubViews() {
        title = "药聚惠"
        view.addSubview(yaojuhuiView)
        yaojuhuiView.collectionView.addHeader { [weak self] in
            self?.refreshData()
        }
        
        let footer = MJRefreshAutoStateFooter { [weak self] in
            self?.loadmore()
        }
        footer.setTitle("已经到底了", for: .noMoreData)
        footer.stateLabel?.textColor = .white
        footer.stateLabel?.font = UIFont.systemFont(ofSize: 12)
        footer.isHidden = true
        yaojuhuiView.collectionView.mj_footer = footer
        
        yaojuhuiView.actionsClosure = { [weak self] (name, index) in
            LYPrint(name, index)
            self?.router(name: name, index: index)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        yaojuhuiView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

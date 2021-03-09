//
//  LYHomeController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/9/28.
//

import UIKit

// MARK: - Actions
extension LYHomeController {
    
    override func router(name: String, index: Int) {
        //  选中banner
        if name == "banner" {
            guard let model = viewModel.homeDataRelay.value.banner?[index], let type = model.type else { return }
            if type == 0 && (model.url?.isEmpty ?? true) { return }
            /// 0商品详情 1商品列表 2活动页面 3药聚会 4标签列表 5积分商城 6电子发票 7控销专区 8爆品列表 如果0 && url==nil 那么不做响应
            switch type {
            case 2:
                let vc = LYH5ActivityController()
                vc.urlString = model.url
                vc.title = model.name
                navigationController?.pushViewController(vc)
            default:
                break
            }
        }
        
        if name == "秒杀查看更多" {
            
        }
        
        if name == "秒杀商品点击" {
            
        }
        
        if name == "秒杀商品购买" {
            
        }
        
        if name == "龙一周选查看更多" {
            
        }
        
        if name == "龙一周选点击" {
            let vc = LYGoodsController()
            let model = viewModel.homeDataRelay.value.lyzx?.first?.goods?[index]
            vc.viewModel.goodsID = model?.id ?? 0
            navigationController?.pushViewController(vc)
        }
        
        if name == "龙一周选购买" {
            let model = viewModel.homeDataRelay.value.lyzx?.first?.goods?[index]
            presentCartView(model ?? LYGoodsModel())
        }
        
        if name == "middle点击商品" {
            let vc = LYGoodsController()
            //  这里回调的是商品id
            vc.viewModel.goodsID = index
            navigationController?.pushViewController(vc)
        }
        
        if name == "厂家特惠" {
            
        }
        
        if name == "厂家特惠查看更多" {
            
        }
        
        if name == "厂家特惠点击" {
            let vc = LYGoodsController()
            let model = viewModel.homeDataRelay.value.cjzz_goods?.first?.goods?[index]
            vc.viewModel.goodsID = model?.id ?? 0
            navigationController?.pushViewController(vc)
        }
        
        if name == "厂家特惠购买" {
            let model = viewModel.homeDataRelay.value.cjzz_goods?.first?.goods?[index]
            presentCartView(model ?? LYGoodsModel())
        }
        
        if name == "药聚会点击分类" {
            guard let naviModel = homeView.yjhNaviData?[index] else { return }
            viewModel.yjhId = naviModel.id ?? 0
            viewModel.yjhType = naviModel.type ?? 0
            viewModel.getYjhGoods(nil)
        }
        
        if name == "药聚会" {
            let vc = LYGoodsController()
            let model = viewModel.yjhGoodsRelay.value[index]
            vc.viewModel.goodsID = model.id ?? 0
            navigationController?.pushViewController(vc)
        }
        
        if name == "药聚会购物车" {
            let model = viewModel.yjhGoodsRelay.value[index]
            presentCartView(model)
        }
        
        if name == "药聚会查看全部" {
            let vc = LYYaojuhuiController()
            navigationController?.pushViewController(vc)
        }
        
        if name == "优选爆品点击" {
//            let vc = LYGoodsController()
//            let model = viewModel.homeDataRelay.value.yxbp?.first?.goods?[index]
//            vc.viewModel.goodsID = model?.id ?? 0
//            navigationController?.pushViewController(vc)
        }
        
        if name == "秒杀查看更多" {
            LYPrint("11111")
        }
        
        if name == "优选爆品查看更多" {
            let vc = LYYxbpController()
            navigationController?.pushViewController(vc)
        }
        
        if name == "品牌专区查看更多" {
            let vc = LYPpzqController()
            navigationController?.pushViewController(vc)
        }
        
        if name == "为你推荐点击" {
            let vc = LYGoodsController()
            let model = viewModel.wntjListDataRelay.value[index]
            vc.viewModel.goodsID = model.id ?? 0
            navigationController?.pushViewController(vc)
        }
        
        if name == "为你推荐购物车" {
            let model = viewModel.wntjListDataRelay.value[index]
            presentCartView(model)
        }
        LYPrint(name)
    }
    
    func yjhTagAction(_ index: Int) {
        let list = viewModel.yjhNaviRelay.value
        let model = list[index]
        viewModel.yjhId = model.id ?? 0
        viewModel.yjhType = model.type ?? 0
        viewModel.getYjhGoods(nil)
    }
    
    /// 购物车选择器
    func presentCartView(_ model: LYGoodsModel) {
        let vc = LYModalCartController()
        vc.cartView.model = model
        present(vc, animated: true, completion: nil)
    }
    
}

extension LYHomeController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
        bind()
        UIActions()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
        
    override func bind() {
        
        viewModel.homeDataRelay.skip(1).subscribe(onNext: { [weak self] homedata in
            self?.homeView.ADdata = homedata
        }).disposed(by: disposeBag)
        
        viewModel.miaoshaDataRelay.skip(1).subscribe(onNext: { [weak self] data in
            self?.homeView.miaoshaData = data
        }).disposed(by: disposeBag)
        
        viewModel.brandListDataRelay.skip(1).subscribe(onNext: { [weak self] list in
            self?.homeView.brandListData = list
        }).disposed(by: disposeBag)
        
        viewModel.wntjListDataRelay.skip(1).subscribe(onNext: { [weak self] list in
            self?.homeView.wntjListData = list
        }).disposed(by: disposeBag)
        
        viewModel.yjhNaviRelay.skip(1).subscribe(onNext: { [weak self] list in
            self?.homeView.yjhNaviData = list
            let first = list.first
            self?.viewModel.yjhId = first?.id ?? 0
            self?.viewModel.yjhType = first?.type ?? 0
            self?.viewModel.getYjhGoods(nil)
        }).disposed(by: disposeBag)
        
        viewModel.yjhGoodsRelay.skip(1).subscribe(onNext: { [weak self] list in
            self?.homeView.yjhGoodsData = list
        }).disposed(by: disposeBag)
        
    }
    
    override func UIActions() {
        homeView.naviView.searchView.rx.tapGesture().skip(1).subscribe { _ in
            LYPrint("搜索")
        }.disposed(by: disposeBag)
        
        homeView.actionsClosure = { [weak self] (name, index) in
            self?.router(name: name, index: index)
        }

    }
                
    override func loadData() {
        
        viewModel.getAdData { [weak self] (error) in
            self?.homeView.collectionView.endRefreshing()
            if error == LYRequestError.success {
                self?.homeView.collectionView.endRefreshing()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
        
        viewModel.getMiaoshaData { [weak self] (error) in
            if error == LYRequestError.success {
                self?.homeView.collectionView.endRefreshing()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
        
        viewModel.getBrandList { [weak self] (error) in
            if error == LYRequestError.success {
                self?.homeView.collectionView.endRefreshing()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
        
        viewModel.getWntjList(isRefresh: true) { [weak self] (_, hasmore) in
            if hasmore {
                self?.homeView.collectionView.mj_footer?.isHidden = false
                self?.homeView.collectionView.resetNoMoreData()
            } else {
                self?.homeView.collectionView.mj_footer?.isHidden = true
            }
        }
        
        viewModel.getYjhNavi { (error) in
            if error == LYRequestError.success {
                self.homeView.collectionView.endRefreshing()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
        
    }
    
    override func loadmore() {
        viewModel.getWntjList(isRefresh: false) { [weak self] (error, hasmore) in
            self?.homeView.collectionView.endRefreshing()
            if error != LYRequestError.success {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
            if !hasmore {
                self?.homeView.collectionView.noMoreData()
            }
        }
    }
    
}

//  MARK: - UI
class LYHomeController: BaseViewController {
    
    let viewModel = LYHomeViewModel()
    let homeView = LYHomeView()
    
    override func initSubViews() {
        view.backgroundColor = UIColor(hexString: "#F5F5F5")
        view.addSubview(homeView)
        navigationController?.navigationBar.isHidden = true
        homeView.collectionView.addHeader { [weak self] in
            self?.loadData()
        }
        homeView.collectionView.addFooter { [weak self] in
            self?.loadmore()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

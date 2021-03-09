//
//  LYGoodsController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/5.
//

import UIKit
import JXSegmentedView

extension LYGoodsController {
    
    override func router(name: String, index: Int) {
        if name == "为你推荐点击" {
            let vc = LYGoodsController()
            let model = viewModel.tuijianRelay.value[index]
            vc.viewModel.goodsID = model.id ?? 0
            navigationController?.pushViewController(vc)
        }
        
        if name == "点击领券" {
            let vc = LYModalQuanController()
            vc.quanView.model = viewModel.goodsInfoRelay.value.coupon_data?[index]
            vc.viewModel.successRelay.skip(1).subscribe(onNext: { [weak self] isSuccess in
                if isSuccess {
                    self?.loadData()
                }
            }).disposed(by: vc.disposeBag)
            present(vc, animated: true, completion: nil)
        }
        
        if name == "点击查看" {
            LYPrint("进入优惠券")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
        bind()
        loadData()
        UIActions()
    }
    
    override func bind() {
        viewModel.goodsInfoRelay.skip(1).subscribe(onNext: { [weak self] model in
            self?.containerView.reloadData()
            if model.is_favorite ?? 0 == 1 {
                self?.cartView.favoriteButton.isSelected = true
            } else {
                self?.cartView.favoriteButton.isSelected = false
            }
            if model.is_buy ?? 0 == 1 {
                self?.cartView.addCartButton.isEnabled = true
                self?.cartView.addCartButton.titleForNormal = "加入购物车"
                self?.cartView.addCartButton.backgroundColor = Constant.yjhColor
            } else {
                self?.cartView.addCartButton.isEnabled = false
                self?.cartView.addCartButton.titleForNormal = model.buy_button_label
                self?.cartView.addCartButton.backgroundColor = UIColor(hexString: "#CDCDCD")
            }
        }).disposed(by: disposeBag)
        
        viewModel.tuijianRelay.skip(1).subscribe(onNext: { [weak self] _ in
            self?.containerView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    override func loadData() {
        HUD.show(.loading())
        viewModel.getGoodsDetail { (error) in
            if error == LYRequestError.success {
                HUD.hide()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
        
        viewModel.getWntj(nil)
    }
    
    override func UIActions() {
        cartView.favoriteButton.rx.tap.subscribe { [weak self] _ in
            self?.favoriteAction()
        }.disposed(by: disposeBag)
        
        cartView.cartButton.rx.tap.subscribe { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: false)
            LYTabBarController.shared.selectedIndex = 2
        }.disposed(by: disposeBag)
        
        cartView.addCartButton.rx.tap.subscribe { [weak self] _ in
            guard let model = self?.viewModel.goodsInfoRelay.value else { return }
            self?.presentCartView(model)
        }.disposed(by: disposeBag)
    }
    
    /// 购物车选择器
    func presentCartView(_ model: LYGoodsModel) {
        let vc = LYModalCartController()
        /// 这里的goods_image没有值,取banner的第一张
        if model.goods_images?.count ?? 0 > 0 {
            model.goods_image = model.goods_images?.first?.thumb_url
        }
        vc.cartView.model = model
        present(vc, animated: true, completion: nil)
    }
    
    private func favoriteAction() {
        guard let idStr = viewModel.goodsInfoRelay.value.id?.string else { return }
        
        if cartView.favoriteButton.isSelected {
            viewModel.cancelLike(goods_ids: [idStr], completion: { [weak self] (error) in
                if error == LYRequestError.success {
                    HUD.show(.success("已取消")).hide(HUDLastTime)
                    self?.cartView.favoriteButton.isSelected = false
                } else {
                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                }
            })
        } else {
            viewModel.addLike(goods_ids: [idStr], completion: { [weak self] (error) in
                if error == LYRequestError.success {
                    HUD.show(.success("已收藏")).hide(HUDLastTime)
                    self?.cartView.favoriteButton.isSelected = true
                } else {
                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                }
            })
        }
    }
    
}

extension LYGoodsController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentDatasource.titles.count
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index == 0 {
            let goodsView = LYGoodsView()
            goodsView.model = viewModel.goodsInfoRelay.value
            goodsView.tuijianModels = viewModel.tuijianRelay.value
            goodsView.actionClosure = { (name, index) in
                LYPrint(name)
            }
            goodsView.actionClosure = { [weak self] (name, index) in
                self?.router(name: name, index: index)
            }
            return goodsView
        } else {
            let detailView = LYGoodsDetailView.loadFromNib(named: "\(LYGoodsDetailView.self)") as! LYGoodsDetailView
            let sms = viewModel.goodsInfoRelay.value.sms
            let phsm = viewModel.goodsInfoRelay.value.phsm
            detailView.dataSource = [ sms ?? "", phsm ?? ""]
            return detailView
        }
    }
}

//  MARK: - UI
class LYGoodsController: BaseViewController {
    
    var segmentView: JXSegmentedView!
    var segmentDatasource: JXSegmentedTitleDataSource!
    var segmentIndicator: JXSegmentedIndicatorLineView!
    var containerView: JXSegmentedListContainerView!
    var cartView: LYGoodsCartView!
    let viewModel = LYGoodsViewModel()

    override func initSubViews() {
        segmentDatasource = JXSegmentedTitleDataSource()
        segmentDatasource.titles = ["商品", "详情"]
        segmentDatasource.titleSelectedColor = Constant.mainColor
        segmentDatasource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 15)
        segmentDatasource.titleNormalColor = UIColor(hexString: "#666666")!
        segmentDatasource.titleNormalFont = UIFont.systemFont(ofSize: 15)
        
        segmentIndicator = JXSegmentedIndicatorLineView()
        segmentIndicator.indicatorColor = Constant.mainColor
        segmentIndicator.indicatorHeight = 3
        segmentIndicator.verticalOffset = 2
        
        containerView = JXSegmentedListContainerView(dataSource: self)
        view.addSubview(containerView)
                
        segmentView = JXSegmentedView()
        segmentView.dataSource = segmentDatasource
        segmentView.indicators = [segmentIndicator]
        segmentView.listContainer = containerView
        navigationItem.titleView = segmentView
        segmentView.frame = CGRect(x: 0, y: 0, width: 180, height: Constant.navigationBar_height)
        
        cartView = LYGoodsCartView()
        view.addSubview(cartView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(cartView.snp.top)
        }
        
        cartView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(Constant.tabBar_height)
        }
        
    }
    
}

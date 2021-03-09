//
//  LYMineViewModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/12.
//

import UIKit

class LYMineViewModel: BaseViewModel {
    
    let orderHeaderRelay = BehaviorRelay<LYMineOrderHeaderModel>(value: LYMineOrderHeaderModel())
    
}

extension LYMineViewModel {
    
    func logout(_ completion: ((LYError) -> Void)?) {
        API.user.rx.request(User.logout).subscribe { result in
            switch result {
            case .success:
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
//    func getUserInfo(_ completion: ((LYError) -> Void)?) {
//        API.user.rx.request(User.userInfo).mapObject(UserModel.self).subscribe { result in
//            switch result {
//            case .success(let data):
//                UserPreference.shared.setUserInfo(data)
//                completion?(LYRequestError.success)
//            case .error(let error):
//                completion?(error as! LYRequestError)
//            }
//        }.disposed(by: disposeBag)
//    }
    
    func getOrderHeader(_ completion: ((LYError) -> Void)?) {
        API.order.rx.request(Order.orderHeader).mapObject(LYMineOrderHeaderModel.self).subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.orderHeaderRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
}

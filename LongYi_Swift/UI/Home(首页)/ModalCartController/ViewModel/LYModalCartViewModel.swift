//
//  LYModalCartViewModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/9.
//

import UIKit

class LYModalCartViewModel: BaseViewModel {
    
}

extension LYModalCartViewModel {
    
    func addCart(params: [LYAddCartParameterModel], _ completion: ((LYError) -> Void)?) {
        API.cart.rx.request(Cart.add(params)).subscribe { result in
            switch result {
            case .success:
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
}

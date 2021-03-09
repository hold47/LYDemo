//
//  LYPpzqViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/25.
//

import UIKit

extension LYPpzqViewModel {
    
    func getBrandList(_ completion: ((LYError) -> Void)?) {
        API.home.rx.request(Home.brandList).mapObjectList(LYBrandModel.self).subscribe { [weak self] result in
            switch result {
            case .success((let data, _)):
                self?.brandRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
}

class LYPpzqViewModel: BaseViewModel {
    
    let brandRelay = BehaviorRelay<[LYBrandModel]>(value: [])
    
}

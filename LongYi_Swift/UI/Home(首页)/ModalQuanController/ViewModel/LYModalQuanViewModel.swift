//
//  LYModalQuanViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/3.
//

import UIKit

class LYModalQuanViewModel: BaseViewModel {
    
    let successRelay = BehaviorRelay<Bool>(value: false)
    
}

extension LYModalQuanViewModel {
    
    func getQuan(activity_id: Int?, _ completion: ((LYError) -> Void)?) {
        API.quan.rx.request(Quan.get(activity_id: activity_id, category_id: nil)).subscribe { [weak self] result in
            switch result {
            case .success:
                self?.successRelay.accept(true)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
}

//
//  LYAccountManageViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/16.
//

import UIKit

extension LYAccountManageViewModel {
    
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
    
}

class LYAccountManageViewModel: BaseViewModel {
    
}

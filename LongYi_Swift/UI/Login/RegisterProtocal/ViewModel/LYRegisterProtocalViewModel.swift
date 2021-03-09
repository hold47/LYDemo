//
//  LYRegisterProtocalViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/30.
//

import UIKit

class LYRegisterProtocalViewModel: BaseViewModel {
    let contentRelay = BehaviorRelay<String>(value: "")
}

extension LYRegisterProtocalViewModel {
    
    func loadProtocal(_ completion:((LYError) -> Void)?) {
        API.newsCenter.rx.request(NewsCenter.userProtocal).mapObject(LYPostDetailModel.self).subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.contentRelay.accept(data.post?.content ?? "")
                completion?(LYRequestError.success)
            case .error(let error):
            completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
}

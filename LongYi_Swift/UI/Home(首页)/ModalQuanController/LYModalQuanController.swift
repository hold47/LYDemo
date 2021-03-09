//
//  LYModalQuanController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/3.
//

import UIKit

extension LYModalQuanController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(quanView)
        UIActions()
    }
    
    func UIActions() {
        quanView.getButton.rx.tap.subscribe { [weak self] _ in
            guard let model = self?.quanView.model else { return }
            HUD.show(.loading())
            self?.viewModel.getQuan(activity_id: model.id, { (error) in
                if error == LYRequestError.success {
                    HUD.show(.success("已领取")).hide(HUDLastTime)
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
                }
            })
        }.disposed(by: disposeBag)
    }
    
}

class LYModalQuanController: YSModal_presentedVC {

    var quanView = LYModalQuanView.loadFromNib(named: "\(LYModalQuanView.self)") as! LYModalQuanView
    let viewModel = LYModalQuanViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.cornerRadius = 8
        quanView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    //  设置modal的maskView
    override func ys_setupMaskView() -> (bgC: UIColor, alpha: CGFloat) {
        return (.black, 0.4)
    }
    
    //  设置modal的方向和宽高
    override func ys_setupDirectionAndLength() -> (direction: YSModal_direction, length: CGFloat) {
        return (.toTop, 460 + Constant.safeArea.bottom)
    }

}

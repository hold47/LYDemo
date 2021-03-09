//
//  LYRegisterProtocalController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/30.
//

import UIKit

extension LYRegisterProtocalController {
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubViews()
        bind()
        loadData()
    }
    
    override func bind() {
        viewModel.contentRelay.skip(1).subscribe(onNext: { [weak self] content in
            guard let data = content.data(using: .unicode) else {
                return
            }
            
            let attriString = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            self?.contentTextView.attributedText = attriString
        }).disposed(by: disposeBag)
    }
    
    override func loadData() {
        HUD.show(.loading())
        viewModel.loadProtocal { (error) in
            if error == LYRequestError.success {
                HUD.hide()
            } else {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }

}

//  MARK: - UI
class LYRegisterProtocalController: BaseViewController {
    
    let viewModel = LYRegisterProtocalViewModel()
    var type: LYRegisterType = .member
    
    @IBOutlet weak var contentTextView: UITextView!
    
    override func initSubViews() {
        title = "用户协议"
        
        if type == .member {
            isMainColorNavigationBar = true
        } else {
            isMainColorNavigationBar = false
        }
    }

}

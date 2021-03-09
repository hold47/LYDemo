//  Created by yaoshuai on 2018/5/22.
//  Copyright © 2018 ys. All rights reserved.

import UIKit

class YSLoadingIndicatorView_default:YSLoadingIndicatorView{
    
    private lazy var loadingIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI(){
        addSubview(loadingIndicatorView)
        
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: loadingIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loadingIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    override func ys_startLoadingIndicatorView() {
        loadingIndicatorView.startAnimating()
    }
    
    override func ys_stopLoadingIndicatorView() {
        loadingIndicatorView.stopAnimating()
    }
}

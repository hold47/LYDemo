//
//  RefreshHeader.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/25.
//

/// 自定义菊花loading
class RefreshHeader: MJRefreshStateHeader {
    
    lazy var loading: HeaderLoading = { [unowned self] in
        let loading = Bundle.main.loadNibNamed("HeaderLoading", owner: self, options: nil)?.first as! HeaderLoading
        loading.bounds = CGRect(x: 0, y: 0, width: 27, height: 27)
        loading.center = self.center
        self.addSubview(loading)
        return loading
    }()
    
    lazy var arrowView: HeaderLoading = { [unowned self] in
        let arrow = Bundle.main.loadNibNamed("HeaderLoading", owner: self, options: nil)?.first as! HeaderLoading
        arrow.bounds = CGRect(x: 0, y: 0, width: 27, height: 27)
        arrow.center = self.center
        self.addSubview(arrow)
        return arrow
    }()
    
    override var state: MJRefreshState {
        willSet {
            if state == newValue {
                return
            }
            
            if newValue == .idle {
                if state == .refreshing {
                    arrowView.transform = .identity
                    
                    UIView.animate(withDuration: TimeInterval(MJRefreshSlowAnimationDuration), animations: {
                        self.loading.alpha = 0.0
                    }, completion: { (finished) in
                        if newValue != .idle { return }
                        
                        self.loading.alpha = 1.0
                        self.loading.hide()
                        self.arrowView.isHidden = false
                    })
                } else {
                    loading.hide()
                    arrowView.isHidden = false
                    UIView.animate(withDuration: TimeInterval(MJRefreshSlowAnimationDuration), animations: {
                        self.arrowView.transform = .identity
                    })
                }
            } else if newValue == .pulling {
                loading.hide()
                arrowView.isHidden = false
                
                UIView.animate(withDuration: TimeInterval(MJRefreshSlowAnimationDuration), animations: {
                    self.arrowView.transform =  CGAffineTransform.init(rotationAngle: 0.000001 - CGFloat(Double.pi))
                })
            } else if newValue == .refreshing {
                loading.alpha = 1.0
                loading.show()
                arrowView.isHidden = true
            }
            
            super.state = newValue
        }
    }
    
    //  MARK: - main
    override func prepare() {
        super.prepare()
        mj_h = 60
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        guard let stateLabel = self.stateLabel, let lastUpdatedTimeLabel = self.lastUpdatedTimeLabel else { return }
        
        if stateLabel.isHidden && lastUpdatedTimeLabel.isHidden {
            loading.contentMode = .center
        } else {
            loading.contentMode = .right
            
            let stateWidth = stateLabel.width
            var timeWidth: CGFloat = 0.0
            
            if lastUpdatedTimeLabel.isHidden == false {
                timeWidth = lastUpdatedTimeLabel.width
            }
            
            let textWidth = stateWidth > timeWidth ? stateWidth : timeWidth
            loading.mj_w = mj_w * 0.5 - textWidth * 0.5 - labelLeftInset
        }
        
        arrowView.center = loading.center
    }
    
}

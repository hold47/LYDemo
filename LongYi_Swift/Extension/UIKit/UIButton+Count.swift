//
//  UIButton+Count.swift
//  WineLife
//
//  Created by 超神—mayong on 2019/9/18.
//  Copyright © 2019 jmq. All rights reserved.
//

import UIKit.UIButton

/// 按钮累加数量
internal protocol CountDelegate: NSObjectProtocol {
    func countButtonDidCount(_ button: UIButton, count: Int)
    func countButtonDidStartCount(_ button: UIButton)
    func countButtonDidStopCount(_ button: UIButton)
}

/// 默认实现协议
extension CountDelegate {
    func countButtonDidStartCount(_ button: UIButton) {}
    func countButtonDidStopCount(_ button: UIButton) {}
}

fileprivate var count_key = "wl.associated.key.button.count"
fileprivate var timer_Key = "wl.associated.key.button.timer"
fileprivate var delegate_key = "wl.associated.key.button.countDelegate"

extension UIButton {
    
    internal var countDelegate: CountDelegate? {
        get { return objc_getAssociatedObject(self, &delegate_key) as? CountDelegate }
        set { objc_setAssociatedObject(self, &delegate_key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN) }
    }
    
    private var count: Int? {
        get { return objc_getAssociatedObject(self, &count_key) as? Int }
        set { objc_setAssociatedObject(self, &count_key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var timer: Timer? {
        get { return objc_getAssociatedObject(self, &timer_Key) as? Timer }
        set { objc_setAssociatedObject(self, &timer_Key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    internal func startCount() {
        
        self.timer?.invalidate()
        self.timer = nil
        self.count = 0
        DispatchQueue.global().async { [weak self] in
             let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                guard let self = self else {
                    timer.invalidate()
                    return
                }
                let tempCount = self.count ?? 0
                self.count = tempCount + 1
                DispatchQueue.main.async {
                    self.countDelegate?.countButtonDidCount(self, count: self.count ?? 0)
                }
            })
            self?.timer = timer
            RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
            RunLoop.current.run()
        }
        self.countDelegate?.countButtonDidStartCount(self)
    }
    
    internal func stopCount() {
        self.timer?.invalidate()
        self.timer = nil
        self.countDelegate?.countButtonDidStopCount(self)
    }
}

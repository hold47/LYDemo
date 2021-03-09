//
//  HeaderLoading.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/25.
//

import UIKit

class HeaderLoading: UIView {
    
    @IBOutlet weak var indicator: UIImageView!
    
    var needToContinueRotating = false
    private var animating = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(continueRotating), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    func show() {
        if animating == false {
            isHidden = false
            animating = true
            rotate()
        }
    }
    
    func hide() {
        animating = false
        isHidden = true
        indicator.layer.removeAllAnimations()
    }
    
    private func rotate() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.duration = 0.5
        anim.byValue = NSNumber(value: Double.pi * 2)
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = false
        indicator.layer.add(anim, forKey: nil)
    }
    
    @objc private func continueRotating() {
        if needToContinueRotating {
            rotate()
            needToContinueRotating = false
        }
    }

}

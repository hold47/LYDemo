//
//  Marquee.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/25.
//

import UIKit

/// 跑马灯,循环titleViewV
class MarqueeView: UIView {
    private var lableArray: Array<UIView> = []
    private lazy var lable  = UILabel()
    private lazy var nextLable = UILabel()
    private var timer: CADisplayLink?
    private var titleString: String?
    private let speed: CGFloat = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(lable)
        self.addSubview(nextLable)
        self.layer.masksToBounds = true
        
        lable.textColor = UIColor(hexString: "f25767")
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 11)
        nextLable.textColor = UIColor(hexString: "f25767")
        nextLable.textAlignment = .center
        nextLable.font = UIFont.systemFont(ofSize: 11)
    }
    
    func configerTitle(title: String?) {
        if title == titleString {
            let size = lable.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 10))
            let h = self.bounds.size.height
            lable.bounds = CGRect(x: 0, y: 0, width: size.width, height: h)
            nextLable.bounds = CGRect(x:0, y: 0, width: size.width, height: h)
            return
        }
        titleString = title
        invalidTimer()
        lable.text = title
        
        let size = lable .sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 10))
        let maxWidth = self.bounds.size.width
        let h = self.bounds.size.height
        lable.frame = CGRect(x: 0, y: 0, width: size.width, height: h)
        if size.width > maxWidth {
            self.addSubview(nextLable)
            creactTimer()
            nextLable.text = title
            nextLable.frame = CGRect(x: lable.frame.maxX + 10, y: 0, width: size.width, height: h)
        } else {
            nextLable.text = nil
            nextLable.removeFromSuperview()
        }
    }
    
    private func creactTimer() {
        invalidTimer()
        
        let disPlayLink = CADisplayLink(target: self, selector: #selector(ontimer))
        disPlayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
        disPlayLink.isPaused = false
        timer = disPlayLink
    }
    
    @objc func ontimer() {
        lable.frame = CGRect(x: lable.frame.minX - speed, y: 0, width: lable.frame.width, height: lable.frame.height)
        nextLable.frame = CGRect(x: nextLable.frame.minX - speed, y: 0, width: nextLable.frame.width, height: nextLable.frame.height)
        
        if lable.frame.maxX < 0 {
            lable.frame = CGRect(x: nextLable.frame.maxX + 10, y: 0, width: lable.frame.width, height: lable.frame.height)
        }
        if nextLable.frame.maxX < 0 {
            nextLable.frame = CGRect(x: lable.frame.maxX + 10, y: 0, width: nextLable.frame.width, height: nextLable.frame.height)
        }
    }
    
    private func invalidTimer(){
        timer?.isPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = self.bounds.height/2
        self.layer.cornerRadius = height
        if lable.frame.height < height {
            configerTitle(title: titleString)
        }
    }
    
    deinit {
        invalidTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  LYAnnounceView.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/25.
//

import UIKit

/// 公告view
class FFAnnouncementView: UIView {
    
    var titleLabel: UILabel?
    lazy var cycleTitleView: MarqueeView = {
        let view = MarqueeView()
        view.configerTitle(title: "")
        addSubview(view)
        return view
    }()
    
    func buildView() {
        let imageView = UIImageView(image: UIImage(named: "nav_notice_icon"))
        backgroundColor = UIColor(hexString: "f2f2fe")
        layer.cornerRadius = 5
        addSubview(imageView)
        imageView.frame = CGRect(x: 12, y: 5, width: 20, height: 20)
     
        let titleLabel = UILabel(text: "公告:", fontSize: 11, TextAlignment: .left, textColor: UIColor(hexString: "f25767")!)
        addSubview(titleLabel)
        titleLabel.frame = CGRect(x: imageView.maxX + 5, y: 0, width: 30, height: self.height)
        cycleTitleView.frame = CGRect(x: titleLabel.maxX + 8, y: 0, width: self.width - titleLabel.maxX - 15, height: self.height)
    
        self.titleLabel = titleLabel
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

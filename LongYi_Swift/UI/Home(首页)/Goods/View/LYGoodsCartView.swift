//
//  LYGoodsCartView.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/5.
//

import UIKit

class LYGoodsCartView: UIView {
    
    var favoriteButton: UIButton!
    var cartButton: UIButton!
    var addCartButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func initSubviews() {
        favoriteButton = UIButton(type: .custom)
        favoriteButton.imageForNormal = UIImage(named: "goods_favorite")
        favoriteButton.imageForSelected = UIImage(named: "goods_favorite_select")
        favoriteButton.titleForNormal = "收藏"
        favoriteButton.titleColorForNormal = UIColor(hexString: "#999999")
        favoriteButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        favoriteButton.centerTextAndImage(imageAboveText: true, spacing: 2)
        addSubview(favoriteButton)
        
        cartButton = UIButton(type: .custom)
        cartButton.imageForNormal = UIImage(named: "goods_cart")
        cartButton.titleForNormal = "购物车"
        cartButton.titleColorForNormal = UIColor(hexString: "#999999")
        cartButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        cartButton.centerTextAndImage(imageAboveText: true, spacing: 2)
        addSubview(cartButton)
        
        addCartButton = UIButton(text: "加入购物车", textColor: .white, font: UIFont.systemFont(ofSize: 18))
        addCartButton.backgroundColor = UIColor(hexString: "#0CB95F")
        addSubview(addCartButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        favoriteButton.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        cartButton.snp.makeConstraints { (make) in
            make.left.equalTo(favoriteButton.snp.right).offset(20)
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addCartButton.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(220)
        }
    }
}

//
//  LYOrderGoodModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/8.
//

import UIKit

struct LYOrderGoodModel: Codable {
    /// ID
    var id: Int?
    /// 订单ID
    var order_id: Int?
    /// goodID
    var goods_id: Int?
    var number: Int?
    /// 仓库号
    var ck_number: Int?
    /// 有效期
    var yxq: String?
    var price: String?
    var type: Int?
    var total_amount: String?
    var goods: LYGoodsModel?

}

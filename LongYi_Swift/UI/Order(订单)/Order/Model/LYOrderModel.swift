//
//  LYOrderModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/7.
//

import Foundation

struct LYOrderModel: Codable {
    /// id
    var id: Int?
    var user: LYClientModel?
    /// 序号
    var order_sn: String?
    /// 药品数量
    var goods_amount: String?
    /// 快递号
    var shipping_id: Int?
    var pay_id: Int?
    /// 地址
    var address: LYAddressModel?
    var is_trans: Int?
    var type: Int?
    var remarks: String?
    /// 支付方式
    var payment: [String: String]?
    
    ///
    var order_status: Int?
    /// 订单状态label
    var order_status_label: String?
    ///
    var order_type: Int?
    ///
    var pay_status: Int?
    /// 删除日期
    var deleted_at: String?
    /// 创建日期
    var created_at: String?
    /// 订单物品
    var order_goods: [LYOrderGoodModel]?
}

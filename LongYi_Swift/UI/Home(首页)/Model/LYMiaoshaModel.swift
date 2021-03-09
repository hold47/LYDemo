//
//  LYMiaoshaModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2021/3/2.
//

import Foundation

struct LYMiaoshaModel: Codable {
    var timestamp: Int?
    var url: String?
    var spike_notice: LYMiaoshaSpikeModel?
}

struct LYMiaoshaSpikeModel: Codable {
    var is_show: Int?
    var is_last: Int?
    var start_time: Int?
    var end_time: Int?
    var data: LYMiaoshaSpikeDataModel?
}

struct LYMiaoshaSpikeDataModel: Codable {
    var id: Int?
    var activity_id: String?
    var start_time: String?
    var end_time: String?
    var number: String?
    var tag: String?
    var remarks: String?
    var is_enabled: String?
    var spikegoods: [LYMiaoshaGoodsModel]?
    var spikegoodsspecial: [LYMiaoshaGoodsModel]?
}

struct LYMiaoshaGoodsModel: Codable {
    var ori_number: String?
    var goods_user: String?
    var spike_id: String?
    var with_coupon: String?
    var goods_region: String?
    var ori_price: String?
    var goods_rank: String?
    /// 有效期
    var yxq: String?
    var is_enabled: String?
    var name: String?
    /// 药品规格
    var ypgg: String?
    /// 包装单位
    var bzdw: String?
    var remarks: String?
    /// 经营范围
    var jyfw: String?
    var id: Int?
    var goods_id: String?
    var goods_allow_user: String?
    /// 限购数量
    var xg_number: String?
    /// 生产厂家
    var sccj: String?
    var number: Int?
    /// 中包装
    var zbz: String?
    var price: String?
    var image: String?
    var tag: String?
    var type: String?
}

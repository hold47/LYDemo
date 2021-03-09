//
//  LYHomeADModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/5.
//

import Foundation

struct LYHomeADModel: Codable {
    var banner: [LYADModel]?
    var icon: [LYADModel]?
    /// 抽奖,只取数组第一个
    var icon_down: [LYADModel]?
    var lyzx: [LYADModel]?
    var middle: [LYADModel]?
    var floor: [LYADModel]?
    var cjzz_goods: [LYADModel]?
    var pop: [LYADModel]?
    var lyzx_id: String?
    var cjzz_id: String?
    var bgc: String?
    var tj_url: String?
}

struct LYADModel: Codable {
    var id: Int?
    var name: String?
    var bgc: String?
    var ads: String?
    var view_more: String?
    /// 0商品详情 1商品列表 2活动页面 3药聚会 4标签列表 5积分商城 6电子发票 7控销专区 8爆品列表 9中药专区    如果0 && url==nil 那么不做响应
    var type: Int?
    var url: String?
    var image: String?
    var goods: [LYGoodsModel]?
    var tag_goods_count: Int?
}

//
//  LYGoodsModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/9/30.
//

import Foundation

class LYGoodsModel: Codable {
    /// 商品id
    var id: Int?
    /// 商品名称
    var name: String?
    /// 现价
    var price: String?
    /// 原价
    var base_price: String?
    /// 券后价
    var coupon_after_price: String?
    /// 数量
    var number: Int?
    /// 库存文字描述
    var number_label: String?
    /// 列表图片
    var goods_image: String?
    /// banner图片
    var goods_images: [LYGoodsImageModel]?
//    var goods_video
//    var ladder_price
    /// 标签
    var tags: [LYGoodsTagModel]?
    /// 生产厂家
    var sccj: String?
    /// 批准文号
    var pzwh: String?
    /// 药品规格
    var ypgg: String?
    /// 件装量
    var jzl: Int?
    /// 中包装
    var zbz: Int?
    /// 包装单位
    var bzdw: String?
    /// 建议零售价
    var market_price: String?
    /// 是否控销
    var is_kxpz: Int?
    /// 是否优选
    var is_youx: Int?
    /// 有效期
    var yxq: String?
    /// 仓库ID
    var ck_id: Int?
    /// 限购数量
    var xg_number: Int?
    /// 限购数量描述
    var xg_number_desc: String?
    /// 能否购买
    var is_buy: Int?
    /// 无法购买理由
    var cant_buy_reason: String?
    /// 是否使用优惠券
    var with_coupon: Int?
    /// 优惠券描述
    var with_coupon_desc: String?
    /// 是否收藏
    var is_favorite: Int?
    /// 是否满减
    var is_goods_manjian: Int?
    /// 效期   1红色
    var is_xq: Int?
    /// 满减描述
    var goods_manjian_disc: String?
    /// 是否买赠
    var is_mzhg: Int?
    /// 买赠描述
    var mzhg_desc: String?
    /// 购买按钮描述
    var buy_button_label: String?
    /// 说明书
    var sms: String?
    /// 配货说明
    var phsm: String?
    /// 0西药  1中药  2控销
    var type: Int?
    /// 药品总价格
    var amounts: String?
    /// 是否特价
    var is_tj: Int?
    /// 活动id
    var activity_id: Int?
    /// 跳转url
    var jump_url: String?
    /// 活动名称
    var activity_name: String?
    /// 优惠券
    var coupon_data: [LYCouponModel]?
    ///
//    var manjian_data: []?
    
}

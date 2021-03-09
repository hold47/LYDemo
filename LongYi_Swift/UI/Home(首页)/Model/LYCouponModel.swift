//
//  LYCouponModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/18.
//

import Foundation

struct LYCouponModel: Codable {
    var id: Int?
    var activity_id: Int?
    var name: String?
    var tag: String?
    var remarks: String?
    /// 是否参加活动（参加即领取）
    var is_get: Int?
    /// 现金券购买链接
    var xjq_buy_url: String?
    /// 0.优惠劵；1、现金券
    var type: Int?
    var price: String?
    var money: String?
    var number: Int?
    var amount: String?
    var created_at: String?
    var updated_at: String?
    var activity_coupon: LYActivityCoupon?
    var items: [LYQuanItemModel]?
}

struct LYQuanItemModel: Codable {
    var id: Int?
    var name: String?
    var money: String?
    var amount: String?
    var remarks: String?
}

struct LYActivityCoupon: Codable {
    var id: Int?
    var role_id: Int?
    var name: String?
    var remarks: String?
    var start_time: String?
    var end_time: String?
    var rule_start_time: String?
    var rule_end_time: String?
    var is_enabled: Int?
    var is_jp: Int?
    var type: Int?
    var created_at: String?
    var updated_at: String?
}

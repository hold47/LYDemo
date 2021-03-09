//
//  LYPayModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/18.
//

import Foundation

struct LYPayModel: Codable {
    var pay: LYPrePayModel?
    var coupon: LYCouponModel?
}

struct LYPrePayModel: Codable {
    /// 预支付订单
    var appid: String?
    /// 商户ID
    var partnerid: String?
    /// 预支付ID
    var prepayid: String?
    /// 时间戳
    var timestamp: String?
    /// 字符串
    var noncestr: String?
    /// 包名
    var package: String?
    /// 签名
    var sign: String?
    /// 支付宝字符串
    var ali_key: String?
}

struct LYOnlinePayModel: Codable {
    /// 支付宝提示
    var memo: String?
    /// 字符串字典
    var result: String?
    /// 状态码
    var resultStatus: Int?
}

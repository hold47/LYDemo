//
//  LYClientModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/9.
//

import Foundation

/// 会员客户
struct LYClientModel: Codable {
    var id: Int?
    var username: String?
    var company: String?
//    var cart: [LYCartOrderModel]?
    var admin: LYClientAdminModel?
}

struct LYClientAdminModel: Codable {
    var id: Int?
    /// 账户名
    var username: String?
    /// 姓名
    var name: String?
    var phone: String?
    var ywy_group_name: String?
}

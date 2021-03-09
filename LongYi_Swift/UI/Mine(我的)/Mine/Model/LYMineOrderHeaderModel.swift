//
//  LYMineOrderHeaderModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/12.
//

import Foundation

struct LYMineOrderHeaderModel: Codable {
    /// 待付款
    var need_to_pay: Int?
    /// 已开票
    var need_to_rec: Int?
    /// 已完成
    var finished: Int?
    /// 已取消
    var deleted: Int?
}

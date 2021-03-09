//
//  LYOrderSearchParameterModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/7.
//

import Foundation

struct LYOrderSearchParameterModel: Codable {
    var page: Int?
    /// 0-全部 1-待付款  2-已开票   3-已完成   4-已取消
    var type: Int?
    var start_time: String?
    var end_time: String?
}

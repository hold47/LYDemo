//
//  LYYxbpAdModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/25.
//

import UIKit

struct LYYxbpAdModel: Codable {
    var banner: [LYADModel]?
    /// 优选特推
    var banner_down: [LYADModel]?
    /// 优选积分
    var score: Int?
    /// 账户积分
    var points: Int?
}

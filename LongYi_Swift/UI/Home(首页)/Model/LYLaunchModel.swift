//
//  LYLaunchModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/26.
//

import Foundation

struct LYLaunchModel: Codable {
    var `switch`: Int?
    var data: [LYLaunchDataModel]?
}

struct LYLaunchDataModel: Codable {
    var id: Int?
    var name: String?
    /// 背景颜色
    var bgc: String?
    var type: Int?
    var url: String?
    var image: String?
}

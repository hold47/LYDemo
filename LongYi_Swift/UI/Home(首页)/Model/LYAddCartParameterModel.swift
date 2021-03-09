//
//  LYAddCartParameterModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/12/4.
//

import Foundation

struct LYAddCartParameterModel: Codable {
    var goods_id: Int?
    var price: String?
    var number: Int?
    /// 仓库ID
    var ck_id: Int?
}

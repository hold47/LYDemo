//
//  LYGoodsCategoryModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/11.
//

import Foundation

struct LYGoodsCategoryModel: Codable {
    var id: Int?
    var name: String?
    var logo: String?
    var children: [LYGoodsCategoryModel]?
}

//
//  LYPostDetailModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/1.
//

import Foundation

struct LYPostDetailModel: Codable {
    var post: LYPostDetailPostModel?
    var last: LYPostDetailNextModel?
    var next: LYPostDetailNextModel?
}

struct LYPostDetailPostModel: Codable {
    var id: Int?
    var title: String?
    var tag: Int?
    var category_id: Int?
    var author: String?
    var summary: String?
    var content: String?
    var image: String?
    var order: Int?
    var is_enabled: Int?
    var created_at: String?
    var updated_at: String?
}

struct LYPostDetailNextModel: Codable {
    var id: Int?
    var title: String?
}

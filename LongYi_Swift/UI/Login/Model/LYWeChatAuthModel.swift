//
//  LYWeChatAuthModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/1.
//

import Foundation

struct LYWeChatAuthModel: Codable {
    var access_token: String?
    var expires_in: Int?
    var refresh_token: String?
    var openid: String?
    var scope: String?
    var unionid: String?
}

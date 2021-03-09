//
//  UserModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/24.
//

import Foundation

struct UserModel: Codable {
    var id: Int?
    /// 登录账号
    var username: String?
    var name: String?
    var phone: String?
    var ywy_group_name: String?
}

struct LoginUserSession: Codable {
    var session: String?
}

struct LoginUserToken: Codable {
    let token: String
    var header: String = "Authorization"
}

struct loginModel: Codable {
    struct datas {
        let error : String
    }
    let code: String
}

struct VersionModel: Codable {
    var createBy: String?
    var updateBy: String?
    var updateLog: String?
    var appVersionId: Int = 0
    /// 服务端返回的最新版本号
    var clientVersion: String?
    var isinstall: Int = 0
    var type: Int = 0
    var createTime: String?
    var appName: String?
    var locked: Int = 0
    var flag: Int = 0
    var downloadUrl: String?
    var remarks: String?
    var updateTime: String?
}



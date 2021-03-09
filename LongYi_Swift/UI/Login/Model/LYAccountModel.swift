//
//  LYAccountModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/30.
//

import Foundation

struct LYAccountModel: Codable {
    var phone: Int?
    /// 1药店 2诊所 3商业公司 4连锁公司 5加盟店(龙一) 6加盟店(其他)
    var rank: Int?
    var username: String?
    var password: String?
    var password_confirmation: String?
    var email: String?
    var company: String?
    var contact_name: String?
    var contact_phone: String?
    /// 省
    var province: Int?
    /// 市
    var city: Int?
    /// 区
    var district: Int?
}

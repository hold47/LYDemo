//
//  API+User.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/24.
//

import Foundation

enum User {
    case login(name: String, password: String)
    case loginCode(phone: String)
    case phoneLogin(phone: String, code: String)
    case wechatLogin(unionid: String)
    case launchAD
    case registerCode(phone: String)
    case validRegisterCode(phone: String, code: String)
    /// 单店注册
    case register(account: LYAccountModel)
    /// 会员列表
    case clientList(phone: String)
    case bindWechat(unionid: String)
    case forgetCode(phone: String)
    case validForgetCode(phone: String, username: String, code: String)
    case resetPassword(username: String, password: String, password_confirmation: String)
    case logout
}

extension User: BaseTarget {
    var path: String {
        switch self {
        case .login:
            return "login/userLogin"
        case .loginCode:
            return "login/sms"
        case .phoneLogin:
            return "login/phoneLogin"
        case .wechatLogin:
            return "login/weChatLogin"
        case .launchAD:
            return "ad/start"
        case .registerCode:
            return "register/sms"
        case .validRegisterCode:
            return "register/validate"
        case .register:
            return "register"
        case .clientList:
            return "user/phone"
        case .bindWechat:
            return "user/bindWechat"
        case .forgetCode:
            return "reset/sms"
        case .validForgetCode:
            return "reset/verify"
        case .resetPassword:
            return "reset/password"
        case .logout:
            return "user/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .loginCode:
            return .get
        case .phoneLogin:
            return .post
        case .wechatLogin:
            return .post
        case .launchAD:
            return .get
        case .registerCode:
            return .get
        case .validRegisterCode:
            return .put
        case .register:
            return .post
        case .clientList:
            return .get
        case .bindWechat:
            return .post
        case .forgetCode:
            return .get
        case .validForgetCode:
            return .post
        case .resetPassword:
            return .post
        case .logout:
            return .delete
        }
    }
    
    var task: Task {
        var parameters = self.commonParameters
        
        switch self {
        case .login(let name, let password):
            parameters["username"] = name
            parameters["password"] = password
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .loginCode(let phone):
            parameters["phone"] = phone
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .phoneLogin(let phone, let code):
            parameters["phone"] = phone
            parameters["code"] = code
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .wechatLogin(let unionid):
            parameters["unionid"] = unionid
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .launchAD:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .registerCode(let phone):
            parameters["phone"] = phone
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .validRegisterCode(let phone, let code):
            parameters["phone"] = phone
            parameters["code"] = code
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .register(let account):
            parameters["phone"] = account.phone
            parameters["rank"] = account.rank
            parameters["username"] = account.username
            parameters["password"] = account.password
            parameters["password_confirmation"] = account.password_confirmation
            parameters["email"] = account.email
            parameters["company"] = account.company
            parameters["contact_name"] = account.contact_name
            parameters["contact_phone"] = account.contact_phone
            parameters["province"] = account.province
            parameters["city"] = account.city
            parameters["district"] = account.district
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .clientList(let phone):
            parameters["phone"] = phone
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .bindWechat(let unionid):
            parameters["unionid"] = unionid
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .forgetCode(let phone):
            parameters["phone"] = phone
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .validForgetCode(let phone, let username, let code):
            parameters["phone"] = phone
            parameters["username"] = username
            parameters["code"] = code
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .resetPassword(let username, let password, let password_confirmation):
            parameters["username"] = username
            parameters["password"] = password
            parameters["password_confirmation"] = password_confirmation
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .logout:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}

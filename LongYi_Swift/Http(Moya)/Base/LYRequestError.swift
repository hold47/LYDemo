//
//  LYRequestError.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/24.
//

import Foundation

enum LYRequestError: LYError {
    case success
    case serverError(String?)
    case serializeError
    case notLogin
    case failure
        
    var errorDescription: String? {
        switch self {
        case .success:
            return "网络请求成功"
        case .serverError(let message):
            return message ?? "服务器返回了一个error"
        case .serializeError:
            return "数据解析异常"
        case .notLogin:
            return "请重新登录"
        case .failure:
            return "网络请求失败"
        }
    }
}

func ==(left: LYError, right: LYError) -> Bool {
    return left.errorDescription == right.errorDescription
}

func !=(left: LYError, right: LYError) -> Bool {
    return left.errorDescription != right.errorDescription
}

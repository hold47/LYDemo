//
//  API+Home.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/5.
//

import Foundation

enum Home {
    case homeAD
    case brandList
    case yjhNavi
    case yjhList(id: Int, type: Int, number: Int, page: Int)
    case youxAd
    case youxTejia(page: Int, is_page: Int, page_size: Int)
    case miaosha
}

extension Home: BaseTarget {
    
    var path: String {
        switch self {
        case .homeAD:
            return "ad_new"
        case .brandList:
            return "brand/list/18"
        case .yjhNavi:
            return "activity/yjh/nav"
        case .yjhList:
            return "activity/list"
        case .youxAd:
            return "youx/ad"
        case .youxTejia:
            return "youx/tj"
        case .miaosha:
            return "normal/notice"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .homeAD:
            return .get
        case .brandList:
            return .get
        case .yjhNavi:
            return .get
        case .yjhList:
            return .get
        case .youxAd:
            return .get
        case .youxTejia:
            return .get
        case .miaosha:
            return .get
        }
    }
    
    var task: Task {
        var parameters = self.commonParameters
        
        switch self {
        case .homeAD:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .brandList:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .yjhNavi:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .yjhList(let id, let type, let number, let page):
            parameters["id"] = id
            parameters["type"] = type
            parameters["number"] = number
            parameters["page"] = page
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .youxAd:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .youxTejia(let page, let is_page, let page_size):
            parameters["page"] = page
            parameters["is_page"] = is_page
            parameters["page_size"] = page_size
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .miaosha:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
}

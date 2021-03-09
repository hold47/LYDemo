//
//  API+Order.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/7.
//

import Foundation

enum Order {
    case orderList(_ param: LYOrderSearchParameterModel)
    case orderDetail(_ id: Int)
    case orderHeader
}

extension Order: BaseTarget {
    
    var path: String {
        switch self {
        
        
        case .orderList:
            return "order/list"
        case .orderDetail:
            return "order/detail"
        case .orderHeader:
            return "order/header"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        var parameters = self.commonParameters
        switch self {
        
        case .orderList(let param):
            parameters["page"] = param.page
            parameters["type"] = param.type
            parameters["start_time"] = param.start_time
            parameters["end_time"] = param.end_time
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .orderDetail(let id):
            parameters["id"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .orderHeader:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}

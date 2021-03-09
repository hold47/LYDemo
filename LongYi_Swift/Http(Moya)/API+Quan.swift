//
//  API+Quan.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/18.
//

import Foundation

enum Quan {
    case get(activity_id: Int?, category_id: Int?)//  一键领取传activity_id
    case pay(activity_id: String, pay_type: Int)
    case payRetry(order_id: String, pay_type: Int)
}

extension Quan: BaseTarget {
    
    var path: String {
        
        switch self {
        case .get:
            return "coupon"
        case .pay:
            return "double/store"
        case .payRetry:
            return "double/retry"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .get:
            return .post
        case .pay:
            return .post
        case .payRetry:
            return .put
        }
    }
    
    var task: Task {
        var parameters = self.commonParameters
        switch self {
        
        case .get(let activity_id, let category_id):
            parameters["activity_id"] = activity_id
            parameters["category_id"] = category_id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .pay(let activity_id, let pay_type):
            parameters["activity_id"] = activity_id
            parameters["pay_type"] = pay_type
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .payRetry(let order_id, let pay_type):
            parameters["order_id"] = order_id
            parameters["pay_type"] = pay_type
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        
    }
    
    
}

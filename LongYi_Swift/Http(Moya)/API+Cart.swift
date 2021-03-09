//
//  API+Cart.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/10.
//

import Foundation

enum Cart {
    case add(_ params: [LYAddCartParameterModel])
    case list
    
    
    
    case editGoodsNumber(id: Int, number: Int)
    case delete(ids: Int)
    case checkout(ids: String)
    case create(ids: String, pay_id: Int, remarks: String?)
}

extension Cart: BaseTarget {
    
    var path: String {
        switch self {
        case .add:
            return "cart"
        case .list:
            return "cart/list"
            
            
        
        case .editGoodsNumber:
            return "cart/edit"
        case .delete:
            return "cart/delete"
        case .checkout:
            return "cart/checkout"
        case .create:
            return "cart/create"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .add:
            return .post
        case .list:
            return .get
            
            
        
        case .editGoodsNumber:
            return .post
        case .delete:
            return .post
        case .checkout:
            return .post
        case .create:
            return .post
        }
    }
    
    var task: Task {
        var parameters = self.commonParameters
        
        switch self {
        case .add(let params):
            if let data = try? JSONEncoder().encode(params) {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] {
                    parameters["params"] = json
                }
            }
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .list:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
            
            
            
            
        case .editGoodsNumber(let id, let number):
            parameters["id"] = id
            parameters["number"] = number
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .delete(let ids):
            parameters["ids"] = ids
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .checkout(let ids):
            parameters["ids"] = ids
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .create(let ids, let pay_id, let remarks):
            parameters["ids"] = ids
            parameters["pay_id"] = pay_id
            parameters["remarks"] = remarks
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}


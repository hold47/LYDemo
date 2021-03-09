//
//  API+NewCenter.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/30.
//

import Foundation

enum NewsCenter {
    case userProtocal
}

extension NewsCenter: BaseTarget {
    var path: String {
        switch self {
        default:
            return "post/postDetail"
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
        case .userProtocal:
            parameters["type"] = 1
            parameters["id"] = 13
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}

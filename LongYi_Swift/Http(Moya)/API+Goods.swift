//
//  API+Goods.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/9/30.
//

import Foundation

enum Goods {
    case detail(_ id: Int)
    /// 为你推荐id = 1 
    case tag(id: Int, page: Int)
    case list(_ param: LYGoodsSearchParameterModel)
    case favorite(_ goods_ids: String)
    case cancelFavorite(_ goods_ids: String)
    case category(is_youx: Int?, is_zy: Int?)
    
    
    
    case goodsSearch(_ param: LYGoodsBlurSearchParameterModel)
}

extension Goods: BaseTarget {
    
    var path: String {
        switch self {
        case .detail:
            return "goods/detail"
        case .tag:
            return "goods_tag"
        case .list:
            return "goods/list"
        case .favorite:
            return "favorite"
        case .cancelFavorite:
            return "favorite/cancel"
        case .category:
            return "category"
            
            
            
            
        case .goodsSearch:
            return "goods/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .detail:
            return .get
        case .list:
            return .get
        case .tag:
            return .get
        case .favorite:
            return .post
        case .cancelFavorite:
            return .post
        case .category:
            return .get
            
            
            
        case .goodsSearch:
            return .get
        }
    }
    
    var task: Task {
        var parameters = self.commonParameters
        
        switch self {
        case .detail(let id):
            parameters["id"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .list(let param):
            parameters["page"] = param.page
            parameters["category_id"] = param.category_id
            parameters["keywords"] = param.keywords
            parameters["sort"] = param.sort
            parameters["order"] = param.order
            parameters["is_youx"] = param.is_youx
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .tag(let id, let page):
            parameters["page"] = page
            parameters["id"] = id
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .favorite(let goods_ids):
            parameters["goods_ids"] = goods_ids
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .cancelFavorite(let goods_ids):
            parameters["goods_ids"] = goods_ids
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .category(let is_youx, let is_zy):
            if let is_youx = is_youx {
                parameters["is_youx"] = is_youx
            }
            if let is_zy = is_zy {
                parameters["is_zy"] = is_zy
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
            
            
            
            
            
        case .goodsSearch(let params):
            parameters["keywords"] = params.keywords
            parameters["type"] = params.type
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}

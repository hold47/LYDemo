//
//  LYGoodsSearchParameterModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/2.
//

import Foundation

/// 搜索参数model
struct LYGoodsSearchParameterModel {
    var page: Int?
    /// 商品分类  多选 "1,2,3,4"
    var category_id: String?
    /// 关键字
    var keywords: String?
    /// price:价格排序，number:库存排序，sale:销量排序，favorite:收藏排序
    var sort: String?
    /// asc:升序，desc:降序
    var order: String?
    /// 0：所有商品，1：优选商品
    var is_youx: Int?
    /// 是否控销
    var is_kxpz: Int?
    /// 是否西药  1西药 2中药
    var is_xy: Int?
    /// 是否特价
    var is_tj: Int?
    /// 是否阶梯特价
    var is_ladder: Int?
    /// 是否满减
    var is_manjian: Int?
    /// 是否满赠换购
    var is_mzhg: Int?
    /// 是否活动商品筛选
    var is_activity: Int?
}

/// 模糊搜索参数
struct LYGoodsBlurSearchParameterModel {
    var keywords: String = ""
    var type: Int?
}

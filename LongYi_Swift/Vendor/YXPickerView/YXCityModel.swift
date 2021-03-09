//
//  YXCityModel.swift
//  RuFengVideoEditDemo
//
//  Created by godox on 2020/1/10.
//  Copyright © 2020 JackMayx. All rights reserved.
//

import Foundation

/// 数据model
struct YXModel: Codable {
    var id: String?
    var name: String?
    var child: [YXModel]?
}





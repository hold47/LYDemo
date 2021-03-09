//
//  Model+extension.swift
//  WoLawyer
//
//  Created by TLL on 2019/12/16.
//  Copyright © 2019 wo_lawyer. All rights reserved.
//

import UIKit

/// 字典 -> 模型
///
/// - Parameters:
///   - type: 类型
///   - data: 字典数据
func JSONModel<T>(_ type: T.Type, withKeyValues data:[String: Any]) throws -> T where T: Decodable {
    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
    let model = try JSONDecoder().decode(type, from: jsonData)
    return model
}

/// 字典数组 -> 模型数组
///
/// - Parameters:
///   - type: 类型
///   - datas: 字典组数
func JSONModels<T>(_ type: T.Type, withKeyValuesArray datas: [[String: Any]]) throws -> [T]  where T: Decodable {
    var temp: [T] = []
    //    for data in datas {
    //        let model = try JSONModel(type, withKeyValues: data)
    //        temp.append(model)
    //    }
    
    let jsonData = try JSONSerialization.data(withJSONObject: datas, options: [])
    temp = try JSONDecoder().decode([T].self, from: jsonData)
    
    return temp
}

/// 两级字典数组 -> 两级模型数组
///
/// - Parameters:
///   - type: 类型
///   - datas: 字典组数
func JSONModels<T>(_ type: T.Type, withKeyValuesArray datas: [[[String:Any]]]) throws -> [[T]]  where T: Decodable {
    var temp: [[T]] = []
    //    for data in datas {
    //        let model = try JSONModel(type, withKeyValues: data)
    //        temp.append(model)
    //    }
    
    let jsonData = try JSONSerialization.data(withJSONObject: datas, options: [])
    temp = try JSONDecoder().decode([[T]].self, from: jsonData)
    
    return temp
}

/// 模型 -> 字符串
func ModelEncoder<T>(toString model:T) ->String? where T:Encodable{
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    guard let data = try?encoder.encode(model) else {
        return nil
    }
    
    guard let jsonStr = String(data: data, encoding: .utf8) else { return nil }
    
    return jsonStr
}

/// 模型 -> 字典
func ModelEncoder<T>(toDictionary model:T) -> [String:Any]? where T: Encodable {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    guard let data = try? encoder.encode(model) else {
        return nil
    }
    
    guard let jsonStr = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:Any] else { return nil }
    
    return jsonStr
}

/// JSON字符串 -> 模型
func toModel<T>(_ type: T.Type, value: String?) -> T? where T: Decodable {
    guard let value = value else { return nil }
    return toModel(type, value: value)
}

/// JSON字符串 -> 模型
func toModel<T>(_ type: T.Type, value: String) -> T? where T : Decodable {
    let decoder = JSONDecoder()
    decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
    guard let t = try? decoder.decode(T.self, from: value.data(using: .utf8)!) else { return nil }
    return t
}

/// JSON字符串 -> 数组
func arrayFrom(jsonString:String) -> [Dictionary<String, Any>]? {
    guard let jsonData = jsonString.data(using: .utf8) else { return nil }
    guard let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers), let result = array as? [Dictionary<String, Any>] else { return nil }
    return result
}

/// JSON字符串 -> 字典
func dictionaryFrom(jsonString:String) -> Dictionary<String, Any>? {
    guard let jsonData = jsonString.data(using: .utf8) else { return nil }
    guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers), let result = dict as? Dictionary<String, Any> else { return nil }
    return result
}

/// 根据plist地址获取数组
/// - Parameter plistName: plist名字
/// - Returns: json数组
func arrayFrom(plistName : String) -> NSArray? {
    let path = Bundle.main.path(forResource: "\(plistName).plist", ofType: nil)
    return NSArray(contentsOfFile: path ?? "")
}

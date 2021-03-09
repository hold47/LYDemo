//
//  API+MapObject.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/24.
//

import Foundation

struct Object<D: Decodable>: Decodable {
    let message: String?
    let data: D?
}

struct ObjectList<D: Decodable>: Decodable {
    let message: String?
    let data: [D]?
    let meta: ListInfo?
}

struct ListInfo: Decodable {
    let current_page: Int?
    let last_page: Int?
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func mapObject<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder(), failsOnEmptyData: Bool = true) -> Single<D> {
        return flatMap { response -> Single<D> in
            do {
                let data = try response.map(Object<D>.self, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)
                return Single.just(data.data ?? "JSONDecodeError" as! D)
            } catch {
                LYPrint(error)
                LYPrint(type)
                return Single.error(LYRequestError.serializeError)
            }
        }
    }
    
    func mapObjectList<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder(), failsOnEmptyData: Bool = true) -> Single<([D], Bool)> {
        return flatMap({ response -> Single<([D], Bool)> in
            do {
                let data = try response.map(ObjectList<D>.self, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)
                let hasmore = !(data.meta?.current_page == data.meta?.last_page)
                return Single.just((data.data ?? [], hasmore))
            } catch {
                LYPrint(error)
                LYPrint(type)
                return Single.error(LYRequestError.serializeError)
            }
        })
    }
    
}

//
//  PlistProperty.swift
//  fireflyLive
//
//  Created by Hold on 2020/7/8.
//  Copyright © 2020 RuiHanTeck. All rights reserved.
//

import Foundation

public struct DefaultPlistProperty<Value: Codable> {

    public let key: Plist.Key
    public let defaultValue: Value?
    
    public init(key: Plist.Key, defaultValue: Value?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: Value? {
        get {
            if Plist.default.valueIsBaseType(Value.self) {
                return Plist.default[self.key] ?? self.defaultValue
            } else if let data: Data = Plist.default[self.key] {
                let jsonDecoder = JSONDecoder()
                return try? jsonDecoder.decode(Value.self, from: data)
            } else {
                return nil
            }
        } set {
            if Plist.default.valueIsBaseType(Value.self) {
                Plist.default[self.key] = newValue
            } else {
                let jsonEncoder = JSONEncoder()
                let data = try? jsonEncoder.encode(newValue)
                Plist.default[self.key] = data
            }
        }
    }
}

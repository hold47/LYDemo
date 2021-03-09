//
//  Plist.swift
//  fireflyLive
//
//  Created by Hold on 2020/7/8.
//  Copyright © 2020 RuiHanTeck. All rights reserved.
//

import Foundation

public final class Plist {
    
    public private(set) var path: Path
    public typealias Path = String
    public typealias Key = String
    
    init(path: Path) {
        self.path = path
    }
    
    public static let `default` = Plist(path: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("/default.plist"))
    
    public func set(_ value: Any?, forKey key: Key) {
        self.plistCache[key] = value
    }

    public func value(forKey key: Key) -> Any? {
        return self.plistCache[key]
    }

    public func removeValue(for key: Key) {
        self.plistCache.removeValue(forKey: key)
    }

    public subscript<T>(key: Key) -> T? {
        get { return self.plistCache[key] as? T }
        set { self.plistCache[key] = newValue }
    }

    public func synchronize() {
        (plistCache as NSDictionary).write(toFile: self.path, atomically: true)
    }

    public private(set) lazy var plistCache: [String: Any] = {
        /// create file - check file dir
        let pathDir: String = {
            var pathComponts = self.path.components(separatedBy: "/")
            pathComponts.removeLast()
            return pathComponts.joined(separator: "/")
        }()

        do {
            var isDir: ObjCBool = false
            if !FileManager.default.fileExists(atPath: pathDir, isDirectory: &isDir) || !isDir.boolValue {
                /// file dir not exists
                try FileManager.default.createDirectory(atPath: pathDir, withIntermediateDirectories: true, attributes: nil)
            }

            if FileManager.default.fileExists(atPath: self.path, isDirectory: &isDir) && !isDir.boolValue {
                /// file exists
                return NSDictionary(contentsOfFile: self.path) as! [String: Any]
            }
            /// create file
            let retValue: NSDictionary = NSDictionary()
            retValue.write(toFile: self.path, atomically: true)
            return retValue as! [String: Any]
        } catch {
            fatalError("create path dir error: \(error.localizedDescription)")
        }
    }()
    
}

extension Plist {

    public func valueIsBaseType<V>(_ type: V.Type) -> Bool {
        return type == Int.self || type == Double.self || type == String.self || type == Data.self || type == Date.self || type == Bool.self
    }

    public func set<V: Encodable>(_ value: V?, for key: DefaultsKeys.DefaultsKey<V>) {
        if valueIsBaseType(V.self) {
            self[key.key] = value
        } else {
            let data = try? JSONEncoder().encode(value)
            self[key.key] = data
        }
    }

    public func value<V: Decodable>(for key: DefaultsKeys.DefaultsKey<V>) -> V? {
        if valueIsBaseType(V.self) {
            return self[key.key]
        }
        guard let data: Data = self[key.key] else { return nil }
        return try? JSONDecoder().decode(V.self, from: data)
    }
}

extension Plist {
    public static let infoPlist: Plist = Plist(path: Bundle.main.path(forResource: "info", ofType: "plist")!)
}

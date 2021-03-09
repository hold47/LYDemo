//
//  DefaultKeys.swift
//  fireflyLive
//
//  Created by Hold on 2020/7/8.
//  Copyright © 2020 RuiHanTeck. All rights reserved.
//

import Foundation

extension DefaultsKeys {
    static let loginSession = DefaultsKey<LoginUserSession>(key: "com.ff.defaults.data.session")
    static let userInfo = DefaultsKey<UserModel>(key: "com.ff.defaults.data.userInfo")
    static let auth = DefaultsKey<LYWeChatAuthModel>(key: "com.ff.defaults.data.auth")
    static let is1111 = DefaultsKey<Bool>(key: "com.ff.defaults.data.is1111")
    
    
    
    static let loginToken = DefaultsKey<LoginUserToken>(key: "com.ff.defaults.data.token")
    
    public static let shortVersion = DefaultsKey<String>(key: "CFBundleShortVersionString")
    public static let infoVersion = DefaultsKey<String>(key: "CFBundleInfoDictionaryVersion")
    public static let executable = DefaultsKey<String>(key: "CFBundleExecutable")
    public static let bundleId = DefaultsKey<String>(key: "CFBundleIdentifier")
    public static let bundleVersion = DefaultsKey<String>(key: "CFBundleVersion")
    public static let bundleName = DefaultsKey<String>(key: "CFBundleName")
}

public class DefaultsKeys {
    public final class DefaultsKey<V>: DefaultsKeys {
        var key: Plist.Key
        public init(key: Plist.Key) {
            self.key = key
        }
    }
}

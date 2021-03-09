//
//  LYError.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/1.
//

import Foundation

protocol LYError: LocalizedError {
    var code: Int { get }
}

extension LYError {
    var code: Int { return 100000 }
}

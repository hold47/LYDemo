//
//  Optional+extension.swift
//  WoLawyer
//
//  Created by TLL on 2020/1/2.
//  Copyright © 2020 wo_lawyer. All rights reserved.
//  为字符串的可选值添加分类

import UIKit

//  String?类型进行扩展
extension Optional where Wrapped == String {
    var isEmpty: Bool {
        return self?.isWhitespace ?? true
    }
}

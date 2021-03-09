//
//  LYCartCheckModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/13.
//

import Foundation

struct LYCartCheckModel: Codable {
//    var check_data: [LYCartOrderModel]?
    var address: LYAddressModel?
    var total_amount: String?
    var payment: [LYPaymentModel]?
}


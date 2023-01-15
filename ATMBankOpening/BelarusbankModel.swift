//
//  BelarusbankModel.swift
//  ATMBankOpening
//
//  Created by Nikita on 12.01.23.
//

import Foundation
import Moya
import ObjectMapper

struct Location: Decodable {
    var address: String
    var work_time: String
    var gps_x: String
    var gps_y: String
    var currency: String
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case work_time = "work_time"
        case gps_x = "gps_x"
        case gps_y = "gps_y"
        case currency = "currency"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.address = try container.decode(String.self, forKey: .address)
        self.work_time = try container.decode(String.self, forKey: .work_time)
        self.gps_x = try container.decode(String.self, forKey: .gps_x)
        self.gps_y = try container.decode(String.self, forKey: .gps_y)
        self.currency = try container.decode(String.self, forKey: .currency)
    }
    
}

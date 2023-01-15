//
//  BelarusbankAPI.swift
//  ATMBankOpening
//
//  Created by Nikita on 12.01.23.
//

import Foundation
import Moya

enum BelarusbankAPI {
    case getAllBank
}

extension BelarusbankAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://belarusbank.by/api/atm?")!
    }
    
    var path: String {
        return ""
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllBank:
            return .get
        }
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        
        return .requestParameters(parameters: parameters, encoding: enocding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        var parameters = [String : Any]()
        
        switch self {
            case .getAllBank:
                parameters["city"] = "Минск"
                parameters["ATM_currency"] = "BYN,USD,EUR"
        }
        
        return parameters
    }
    
    var enocding: ParameterEncoding {
        switch self {
            case .getAllBank:
                return URLEncoding.queryString
        }
    }
    
    
}

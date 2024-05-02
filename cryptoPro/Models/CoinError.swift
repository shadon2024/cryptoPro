//
//  CoinError.swift
//  cryptoPro
//
//  Created by Admin on 02/05/24.
//

import Foundation

struct CoinError: Decodable {
    let errorCode: Int
    let errorMassage: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case errorCode = "error_code"
        case errorMassage = "error_massage"
    }
    
  
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let status = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .status)
        
        errorCode = try status.decode(Int.self, forKey: .errorCode)
        errorMassage = try status.decode(String.self, forKey: .errorMassage)
    }
}

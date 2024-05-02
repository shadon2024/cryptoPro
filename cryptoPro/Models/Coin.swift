//
//  Coin.swift
//  cryptoPro
//
//  Created by Admin on 01/05/24.
//

import Foundation


struct CoinArray: Decodable {
    let data: [Coin]
}


struct Coin: Decodable {
    
    let id: Int
    let name: String
    let maxSupply: Int?
    let rank: Int
    let pricingData: PricingData
    
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case maxSupply = "maxSupply"
        case rank = "cmc_rank"
        case pricingData = "quote"
        
    }
    
//    struct Quote {
//        let CAD: CAD
//
//        struct CAD {
//            let price: Double
//            let market_cap: Double
//        }
//    }
    
}


struct PricingData: Decodable {
    let CAD: CAD


}


struct CAD: Decodable {
    let price: Double
    let market_cap: Double
}





//struct PricingData: Decodable {
//    let price: Double
//    let market_cap: Double
//
//    enum CodingKeys: String, CodingKey {
//        case CAD
//        case price
//       ćcase marketCap = "market_cap"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let cad = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .CAD)
//        price = try cad.decode(Double.self, forKey: .price)
//        market_cap = try cad.decode(Double.self, forKey: .marketCap)
//    }
//}


//extension Coin {
//    public static func getMockArray() -> [Coin]{
//        return [
//            Coin(id: 1, name: "Bitcoin", max_supply: 200, cmc_rank: 1, quote: Quote(CAD: Quote.CAD(price: 50000, market_cap: 1_000_000))),
//            Coin(id: 2, name: "Ethereum", max_supply: nil, cmc_rank: 2, quote: Quote(CAD: Quote.CAD(price: 2000, market_cap: 500_000))),
//            Coin(id: 3, name: "Monero", max_supply: nil, cmc_rank: 3, quote: Quote(CAD: Quote.CAD(price: 200, market_cap: 250_000)))
//            ]
//    }
//}



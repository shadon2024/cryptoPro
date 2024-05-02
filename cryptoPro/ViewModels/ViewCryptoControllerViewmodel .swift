//
//  ViewCryptoControllerViewmodel {}.swift
//  cryptoPro
//
//  Created by Admin on 01/05/24.
//

import Foundation
import UIKit

class ViewCryptoControllerViewmodel {
    
    var onImageLoaded: ((UIImage?)->Void)?
    
    
    
    // MARK: - Variables
    let coin: Coin
    
    
    
    // MARK: - Initializer
    init(_ coin: Coin) {
        self.coin = coin
        self.loadImage()
    }
    
    private func loadImage() {
//        let imageData = try? Data(contentsOf: self.coin.logoURL!)
//        if let imageData = imageData {
//            DispatchQueue.main.async { [weak self] in
//                self?.coinLoge.image = UIImage(data: imageData)
//            }
//        }
        
        DispatchQueue.global().async {
            if let logoURL = self.coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {
                self.onImageLoaded?(logoImage)
            }
        }
    }
    
    
    
    // MARK: - Computed Properties
    var rankLabel: String {
        return "Rank: $\(self.coin.rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(self.coin.pricingData.CAD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.pricingData.CAD.market_cap) CAD"
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = self.coin.maxSupply {
            return "Max Supply: \(maxSupply)"
        } else {
            return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123"
        }
        
    }
    
    
}

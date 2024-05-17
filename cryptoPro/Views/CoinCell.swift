//
//  CoinCell.swift
//  cryptoPro
//
//  Created by Admin on 01/05/24.
//

import UIKit
import SDWebImage

class CoinCell: UITableViewCell {


    static let identifier = "CoinCell"
    
    
    // MARK: - Variables
    
    private(set) var coin: Coin!
    
    
    
    // MARK: - UI Components
    
    private var coinLoge: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        return iv
    }()

    
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    
    // MARK: - Lifecucle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with coin: Coin) {
        self.coin = coin
        
        self.coinName.text = coin.name
        self.coinLoge.sd_setImage(with: coin.logoURL)
//        DispatchQueue.global().async {
//            let imageData = try? Data(contentsOf: self.coin.logoURL!)
//            if let imageData = imageData {
//
//                DispatchQueue.main.async { [weak self] in
//                    self?.coinLoge.image = UIImage(data: imageData)
//                }
//            }
//        }
        
    }
    
    
    // TODO: - PrepareForReuse
    

    
    //MARK: - UI Setup
    
    private func setupUI() {
        self.addSubview(coinLoge)
        self.addSubview(coinName)
        
        coinLoge.translatesAutoresizingMaskIntoConstraints = false
        coinName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinLoge.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinLoge.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            coinLoge.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            coinLoge.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            coinName.leadingAnchor.constraint(equalTo:coinLoge.trailingAnchor, constant: 16),
            coinName.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        ])
    }
}

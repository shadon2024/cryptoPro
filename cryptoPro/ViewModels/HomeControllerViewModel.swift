//
//  HomeControllerViewModel.swift
//  cryptoPro
//
//  Created by Admin on 03/05/24.
//

//import Foundation
import UIKit

class HomeControllerViewModel {
    
    var onCoinsUpdated: (() -> Void)?
    var onErrorMessage: ((CoinCerviceError) -> Void)?
    
    
    // MARK: - Variables
    private var inSearchMode: Bool = false
    
    var coins: [Coin] {
        return self.inSearchMode ? filteredCoins : allCoins
    }
    
    
    private(set) var allCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    private(set) var filteredCoins: [Coin] = []
    
    init() {
        self.fetchCoins()
    }
    
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinCervice.fetchCoins(with: endpoint ) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
                print("DEBAG PRINT:", "\(coins.count) coins fetched.")
                
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
}


// MARK: - Search Functions

extension HomeControllerViewModel {
    
    public func setInSearchMode(_ searchController: UISearchController)  {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        self.inSearchMode = isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredCoins = allCoins
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.onCoinsUpdated?(); return}
            
            self.filteredCoins = self.filteredCoins.filter({
                $0.name.lowercased().contains(searchText)
            })
        }
        
        self.onCoinsUpdated?()
    }
}

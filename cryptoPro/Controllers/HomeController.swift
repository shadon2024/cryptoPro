//
//  ViewController.swift
//  cryptoPro
//
//  Created by Admin on 01/05/24.
//

import UIKit

class HomeController: UIViewController {

    // MARK: VAriables
    //private let coins: [Coin] = Coin.getMockArray()
//    private let coins: [Coin] = [
//        Coin(id: 1, name: "Bitcoin", maxSupply: 200, rank: 1, pricingData: PricingData(CAD: CAD(price: 50000, market_cap: 1_000_000))),
//        Coin(id: 2, name: "Ethereum", maxSupply: nil, rank: 2, pricingData: PricingData(CAD: CAD(price: 2000, market_cap: 500_000))),
//        Coin(id: 3, name: "Monero", maxSupply: nil, rank: 3, pricingData: PricingData(CAD: CAD(price: 200, market_cap: 250_000))),
//        Coin(id: 4, name: "Binance Coin", maxSupply: nil, rank: 4, pricingData: PricingData(CAD: CAD(price: 200, market_cap: 250_000))),
//        Coin(id: 5, name: "Tether", maxSupply: 300, rank: 5, pricingData: PricingData(CAD: CAD(price: 200, market_cap: 250_000))),
//        Coin(id: 6, name: "Ton", maxSupply: 300, rank: 6, pricingData: PricingData(CAD: CAD(price: 200, market_cap: 250_000)))
//        ]
    private let viewModel: HomeControllerViewModel
    
    
    // MARK: UI Components
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        return tv
    }()
    
    
    
    // MARK: - LifeCucle
    init (_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupSearchController()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.onCoinsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.onErrorMessage = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                
                switch error {
                case .serverError(let serverError):
                    alert.title = "Server error \(serverError.errorCode)"
                    alert.message = serverError.errorMassage
                case .unknown(let string):
                    alert.title = "Error Fetching Coins"
                    alert.message = string
                case .decodingError(let string):
                    alert.title = "Error Parsing Data"
                    alert.message = string
                }
                
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
    // MARK: UI Setup
    private func setupUI() {
        self.navigationItem.title = "cryptoPro"
        //navigationController?.navigationBar.barTintColor = UIColor.systemGray6
        //navigationController?.navigationBar.tintColor = UIColor.brown
        //navigationController?.navigationBar.backgroundColor = .systemGray6
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            

        ])
    }
    
    
    
    
    // MARK: - Selectors
    
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Cryptos"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.showsBookmarkButton = true
        
        self.searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
    }
}



// MARK: - Search Controller Functions

extension HomeController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.setInSearchMode(searchController)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //print("DEBUG PRINT:", searchController.searchBar.text)
        
        self.viewModel.setInSearchMode(searchController)
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("DEBUG PRINT:", "button clicked")
    }
    
    
}


// MARK: - TableView Functions

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.viewModel.coins.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("Unable to dequeu CoinCell in HomeController")
        }
        
        
        let coin = self.viewModel.coins[indexPath.row]
        
        
        
        cell.configure(with: coin)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let coin = self.viewModel.coins[indexPath.row]
        let vm = ViewCryptoControllerViewmodel(coin)
        let vc = ViewCryptoController(vm)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

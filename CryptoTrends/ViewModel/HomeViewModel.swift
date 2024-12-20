//
//  HomeViewModel.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/11/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    @Published var allCoins: [CoinModel] = []
    private var allCoinsCopy: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    let networkManager: NetworkManagerProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerProtocol){
        self.networkManager = networkManager
        getCoins()
        setUpSearchBinding()
    }
    
    func getCoins(){
        self.networkManager.fetchData(url: APIEndpoint.BaseURL + APIEndpoint.CoinsApiPath, modelType: [CoinModel].self)
            .receive(on: DispatchQueue.main)
            .sink{ completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    print(NetworkError.invalidURL)
                }
            } receiveValue: { [weak self] data in
                self?.allCoins = data
                self?.allCoinsCopy = data
            }.store(in: &cancellables)
        
        
    }
    
    private func setUpSearchBinding(){
        $searchText
        //it will wait for 0.5 seconds after the user finishes typing & then filter, so if users types too much really fast we don't filter every time.
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map{ (text) -> [CoinModel] in
                guard !text.isEmpty else {
                    return self.allCoinsCopy
                }
                //in the sink self.allCoins is updated to empty when no match, so don't filter with that, filter with unmodified array
                let filteredCoins = self.allCoinsCopy.filter{ (coin) -> Bool in
                    return coin.name.lowercased().contains(text.lowercased()) ||
                    coin.symbol.lowercased().contains(text.lowercased()) ||
                    coin.id.lowercased().contains(text.lowercased())
                }
                return filteredCoins
                
            }
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }.store(in: &cancellables)
    }

}



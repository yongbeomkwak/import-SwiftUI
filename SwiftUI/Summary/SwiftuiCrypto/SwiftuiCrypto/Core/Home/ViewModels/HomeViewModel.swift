//
//  HomeViewModel.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/25.
//

import Foundation
import Combine

class HomeViewModel:ObservableObject {
    
    @Published  var statistics: [StatisticModel] = []
    
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable> ()

    
    init(){
        addSubscribers()
    }
    
    func addSubscribers() {
        
        //update allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins) // 실제 전체 코인
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(fillterCoins)
            .sink { [weak self] coins in
                guard let self else {return}
                
                self.allCoins = coins // 필터링 걸러진 코인
            }
            .store(in: &cancellables)
        
        
        //update marketData
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] result in
                guard let self = self else {return}
                
                self.statistics = result
            }
            .store(in: &cancellables)
        
        //update portfolioCoins
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map{ (coinModels,PortfolioEntities)  -> [CoinModel] in
                
                coinModels
                    .compactMap { (coin) -> CoinModel?  in
                        guard let entity = PortfolioEntities.first(where: {$0.coinID == coin.id}) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] coins in
                guard let self else {return}
                
                self.portfolioCoins = coins
                
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin:CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    
    private func fillterCoins(text:String,coins:[CoinModel]) -> [CoinModel] {
        
        guard !text.isEmpty else { // 비어 있으면
            return coins // 전체 코인
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter({ (coin) -> Bool in
            
            return coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
            
        })
        
    }
    
    private func mapGlobalMarketData(marketDataModel:MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap,percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volumn =  StatisticModel(title: "24h Volumn", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00",percentageChange: 0)
        
        stats.append(contentsOf:
            [marketCap,volumn,btcDominance,portfolio]
        )
        
        return stats
    }
    
}

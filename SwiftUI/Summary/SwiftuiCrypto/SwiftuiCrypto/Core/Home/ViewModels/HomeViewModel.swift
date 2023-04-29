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
    
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable> ()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price , priceReversed
    }

    
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
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] result in
                guard let self = self else {return}
                
                self.statistics = result
                self.isLoading = false
            }
            .store(in: &cancellables)
        
        //update portfolioCoins
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] coins in
                guard let self else {return}
                
                self.portfolioCoins = coins
                
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin:CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getCoins()
        HapticManager.notification(type: .success)
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
    
    private func mapAllCoinsToPortfolioCoins(allCoins:[CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        
        allCoins.compactMap({ (coin) -> CoinModel? in
            
            guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                return nil
            }
            
            return coin.updateHoldings(amount: entity.amount)
            
        })
    }
    
    private func mapGlobalMarketData(marketDataModel:MarketDataModel?,portfolioCoins:[CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap,percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volumn =  StatisticModel(title: "24h Volumn", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        
        let portfolioValue = portfolioCoins.map({$0.currentHoldingsValue}).reduce(0,+)
        
        let previousValue = portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = coin.priceChangePercentage24H! / 100
            let previousValue = currentValue / (1+percentChange)
            return previousValue
        }
        .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals() ,percentageChange: percentageChange)
        
        
        stats.append(contentsOf:
            [marketCap,volumn,btcDominance,portfolio]
        )
        
        return stats
    }
    
}

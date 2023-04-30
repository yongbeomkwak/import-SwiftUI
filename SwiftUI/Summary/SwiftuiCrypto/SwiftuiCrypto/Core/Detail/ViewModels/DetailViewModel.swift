//
//  DetailViewModel.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/30.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject {
    
    @Published var overviewStatistics:[StatisticModel] = []
    @Published var additionalStatistics:[StatisticModel] = []
    
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    @Published var coin:CoinModel
    
    init(coin:CoinModel){
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink(receiveValue: {[weak self]  data in
                
                guard let self else {return}
                
                self.overviewStatistics = data.overview
                self.additionalStatistics = data.additional
                
                
            })
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailModel:CoinDetailModel?, coinModel:CoinModel) -> (overview:[StatisticModel],additional:[StatisticModel]) {
        

        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price,percentageChange: pricePercentChange)
        
        let marketCap = "$" +  (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap,percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overViewArray: [StatisticModel] = [
            priceStat,marketCapStat,rankStat,volumeStat
        ]
        
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "N/A"
        let highState = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "N/A"
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        
       
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "N/A"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChageStat = StatisticModel(title: "24h Price Change ", value: priceChange,percentageChange: pricePercentChange2)
        
        
        let marketCapChange =  "$" +  (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketChangeCapStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange,percentageChange: marketCapPercentChange2)
        
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "N/A"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatisticModel] = [
            highState,lowStat,priceChageStat, marketChangeCapStat , blockStat ,hashingStat
        ]
        
        
        return (overViewArray,additionalArray)
    }
    
}

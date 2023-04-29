//
//  CoinDataService.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/25.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    
    init(){
        getCoins()
    }
    
    
    func getCoins(){
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
        
    
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] globalData in
                guard let self else  {return}
                self.marketData = globalData.data
                self.marketDataSubscription?.cancel()
                
            })
           
        
        
    }
    
    
    
}

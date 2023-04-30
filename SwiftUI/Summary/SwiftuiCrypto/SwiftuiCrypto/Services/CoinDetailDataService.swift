//
//  CoinDataService.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/25.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails : CoinDetailModel? = nil
    var coinDetailSubscription: AnyCancellable?
    let coin:CoinModel
    
    
    init(coin:CoinModel){
        self.coin = coin
        getCoinDetails()
    }
    
    
    func getCoinDetails(){
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {return}
        
    
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] coins in
                guard let self else  {return}
                self.coinDetails  = coins
                self.coinDetailSubscription?.cancel()
                
            })
           
        
        
    }
    
    
    
}

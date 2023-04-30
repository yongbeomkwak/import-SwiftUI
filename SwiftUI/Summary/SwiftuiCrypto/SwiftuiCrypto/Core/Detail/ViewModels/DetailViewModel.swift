//
//  DetailViewModel.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/30.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin:CoinModel){
        self.coinDetailService = CoinDetailDataService(coin: coin)
    
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink(receiveValue: { data in
                
            })
            .store(in: &cancellables)
    }
    
}

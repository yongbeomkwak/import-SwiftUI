//
//  HomeViewModel.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/25.
//

import Foundation
import Combine

class HomeViewModel:ObservableObject {
    
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable> ()

    
    init(){
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] coins in
                
                guard let self else {return}
                self.allCoins = coins
            }
            .store(in: &cancellables)
        
    }
    
}

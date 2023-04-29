//
//  HomeViewModel.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/25.
//

import Foundation
import Combine

class HomeViewModel:ObservableObject {
    
    @Published  var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value",percentageChange: 1),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value",percentageChange: -7)
    ]
    
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable> ()

    
    init(){
        addSubscribers()
    }
    
    func addSubscribers() {
        
        $searchText
            .combineLatest(dataService.$allCoins) // 실제 전체 코인
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(fillterCoins)
            .sink { [weak self] coins in
                guard let self else {return}
                
                self.allCoins = coins // 필터링 걸러진 코인
            }
            .store(in: &cancellables)
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
    
}

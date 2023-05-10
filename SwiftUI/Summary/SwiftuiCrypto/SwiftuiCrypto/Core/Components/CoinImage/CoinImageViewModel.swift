//
//  CoinImageViewModel.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/28.
//

import Foundation
import UIKit
import Combine

class CoinImageViewModel : ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    
    private let coin:CoinModel
    private let dataService:CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin:CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers(){
        
        dataService.$image
            .sink(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
                
            }, receiveValue: { [weak self] image in
                
                self?.image = image

            }).store(in: &cancellables)
        
    }
}

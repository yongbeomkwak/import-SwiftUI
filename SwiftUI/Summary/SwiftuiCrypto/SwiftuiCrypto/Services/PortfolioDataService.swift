//
//  PortfolioDataService.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/29.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName : String = "PortfolioContainer" // DataModel 파일명과 같게 설정
    private let entityName:String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (_,error) in
            
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        })
        
        self.getPortfolio()
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
        
        
    }
    
    // MARK: PUBLIC
    
    
    func updatePortfolio(coin:CoinModel, amount:Double){
        
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    
    // MARK: PRIVATE
    
    private func add(coin:CoinModel,amount: Double){
        let entity =  PortfolioEntity(context: container.viewContext)
        
        entity.coinID = coin.id
        entity.amount = amount
        
        applyChange()
    }
    
    private func update(entity: PortfolioEntity, amount:Double) {
        entity.amount = amount
        applyChange()
    }
    
    private func delete(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func save(){
        
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data \(error)")
        }
        
    }
    
    private func applyChange(){
        save()
        getPortfolio()
    }
}

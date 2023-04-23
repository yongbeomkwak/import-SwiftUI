//
//  ListViewModel.swift
//  TodoList
//
//  Created by yongbeomkwak on 2023/04/23.
//

import Foundation

class ListViewModel:ObservableObject {
    
    @Published var items: [ItemModel] = []
    
    init(){
        getItems()
    }
    
    func getItems(){
        let newItem = [
            ItemModel(title: "First Title", isCompleted: false),
            ItemModel(title: "Second Title", isCompleted: false),
            ItemModel(title: "Third Title", isCompleted: false)
        ]
        
        items.append(contentsOf: newItem)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from:IndexSet,to : Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
}

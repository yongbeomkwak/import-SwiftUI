//
//  ItemModel.swift
//  TodoList
//
//  Created by yongbeomkwak on 2023/04/23.
//

import Foundation

struct ItemModel:Identifiable {
    
    let id:String = UUID().uuidString
    let title: String
    let isCompleted: Bool
    
    
}

//
//  TodoListApp.swift
//  TodoList
//
//  Created by yongbeomkwak on 2023/04/23.
//

import SwiftUI

@main
struct TodoListApp: App {
    @StateObject var listViewModel = ListViewModel()
    var body: some Scene {

        WindowGroup {
            NavigationStack{
                ListView()
            }
            
            .environmentObject(listViewModel)
        }
    }
}

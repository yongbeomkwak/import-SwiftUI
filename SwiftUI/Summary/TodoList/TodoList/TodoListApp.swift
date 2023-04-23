//
//  TodoListApp.swift
//  TodoList
//
//  Created by yongbeomkwak on 2023/04/23.
//

import SwiftUI

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
        }
    }
}

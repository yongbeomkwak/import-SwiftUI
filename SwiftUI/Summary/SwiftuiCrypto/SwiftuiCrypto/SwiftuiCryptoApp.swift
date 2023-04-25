//
//  SwiftuiCryptoApp.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/24.
//

import SwiftUI

@main
struct SwiftuiCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(vm)
        }
    }
}

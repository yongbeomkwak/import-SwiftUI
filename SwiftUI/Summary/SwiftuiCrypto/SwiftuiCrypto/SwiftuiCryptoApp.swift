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
    @State private var showLaunchView:Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor:UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationStack{
                    HomeView()
                        .toolbar(.hidden)
                }
                .environmentObject(vm)
                
                ZStack{
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
                
                
            }
            
            
           
        }
    }
}

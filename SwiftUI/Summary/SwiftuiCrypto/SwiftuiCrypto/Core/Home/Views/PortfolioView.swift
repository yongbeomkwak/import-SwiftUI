//
//  PortfolioView.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/29.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var vm: HomeViewModel
    
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading,spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    ScrollView(.horizontal,showsIndicators: true) {
                        LazyHStack(spacing:10){
                            
                            ForEach(vm.allCoins){ coin in
                                Text(coin.symbol.uppercased())
                                
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                   XMarkButton()

                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

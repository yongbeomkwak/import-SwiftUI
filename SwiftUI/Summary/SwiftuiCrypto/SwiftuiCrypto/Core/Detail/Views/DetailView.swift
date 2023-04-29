//
//  DetailView.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/29.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var  coin:CoinModel?
    
    
    init(coin: Binding<CoinModel?>) {
        self._coin = coin
        print("Init Detail with Coin")
        
    }
    
    var body: some View {
        Text("\(coin?.name ?? "")")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: .constant(dev.coin))
    }
}

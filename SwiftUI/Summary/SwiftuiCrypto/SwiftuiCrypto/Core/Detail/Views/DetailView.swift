//
//  DetailView.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/29.
//

import SwiftUI

struct DetailLoadingView : View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    
    @StateObject var vm:DetailViewModel
    
    private let columns:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing:CGFloat = 30
    
    init(coin: CoinModel) {
        
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Init Detail with Coin")
        
    }
    
    var body: some View {
        ScrollView{
            
            VStack(spacing:0){
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing:20){
                                        
                    overviewTitle
                    
                    Divider()
                    
                    ZStack{
                        if let coinDescription = vm.coinDescription,!coinDescription.isEmpty {
                            VStack(alignment: .leading){
                                Text(coinDescription)
                                    .lineLimit(3)
                                    .font(.callout)
                                    .foregroundColor(.theme.secondaryText)
                                
                                Button {
                                    
                                } label: {
                                    Text("Read more..")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .padding(.vertical,4)
                                }
                                .tint(.blue)

                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                        }
                    }
                    
                    overviewGrid
                    
                    additionalTitle
                    
                    Divider()
                    
                    additionalGrid
                }
                .padding()
            }
            
            
        }
        .navigationTitle(vm.coin.name)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing, content: {
                
                navigationBarTrailingItems
            })
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DetailView(coin: dev.coin)
        }
        
        
    }
}

extension DetailView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns,alignment: .leading,spacing: spacing , pinnedViews: []) {
            
            ForEach(vm.overviewStatistics){ stat in
                StatisticView(stat: stat )
            }
            
        }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: columns,alignment: .leading,spacing: spacing , pinnedViews: []) {
            
            ForEach(vm.additionalStatistics){ stat in
                StatisticView(stat: stat)
            }
            
        }
    }
    
    private var navigationBarTrailingItems: some View {
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.secondaryText)
            
            CoinImageView(coin: vm.coin)
                .frame(width: 25,height: 25)
        }
    }
}

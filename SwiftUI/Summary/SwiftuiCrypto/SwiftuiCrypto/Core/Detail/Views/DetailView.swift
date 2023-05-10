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
    @State private var showFullDescription:Bool = false
    
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
                    
                    descriptionSection
                    
                    overviewGrid
                    
                    additionalTitle
                    
                    Divider()
                    
                    additionalGrid
                    
                    websiteSection
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
    
    private var descriptionSection: some View {
        ZStack{
            if let coinDescription = vm.coinDescription,!coinDescription.isEmpty {
                VStack(alignment: .leading){
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                    
                    Button {
                        withAnimation(.easeOut) {
                            showFullDescription.toggle()
                        }
                        
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical,4)
                    }
                    .tint(.blue)

                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
        }
    }
    
    private var websiteSection: some View {
        VStack{
            if let webSiteString = vm.webSiteURL,let url = URL(string: webSiteString) {
                Link("Website",destination: url)
            }
            
            if let redditStirng = vm.redditURL,let url = URL(string: redditStirng) {
                Link("Reddit",destination: url)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity,alignment: .leading)
        .font(.headline)
    }
    
}

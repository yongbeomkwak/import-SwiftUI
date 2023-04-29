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
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading,spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                   
                    coinLogoList
                    
                    
                    if selectedCoin != nil {
                       portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                   XMarkButton()

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                  trailingNavBarButtons

                }
            }
            .onChange(of: vm.searchText, perform: {
                if $0.isEmpty {
                    removeSelectedCoin()
                }
            })
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}


extension PortfolioView{
    
    private var coinLogoList: some View {
        
        ScrollView(.horizontal,showsIndicators: true) {
            LazyHStack(spacing:10){
                
                ForEach(vm.allCoins){ coin in
                    CoinLogoView(coin: coin)
                        .frame(width:75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn){
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : .clear,lineWidth: 1)
                        )
                    
                }
                
            }
            .padding(.vertical,4)
            .padding(.leading)
        }
        .frame(height: 120)
        .padding(.leading)
        
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount in your portfolio:")
            
                Spacer()
                TextField("Ex: 1.4",text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            
            HStack{
                Text("Current value:")
                Spacer()
                Text("\(getCurrentVaule().asCurrencyWith2Decimals())")
            }
            
        }
        .animation(.none, value: selectedCoin)
        .padding()
        .font(.headline)
    }
    
    
    private var trailingNavBarButtons : some View{
        HStack{
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1 : 0)
            

        }
        .font(.headline)
    }
    
    private func getCurrentVaule() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        
        return 0
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin else {return}
        
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
            
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        })
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
    }
    
    
    
}

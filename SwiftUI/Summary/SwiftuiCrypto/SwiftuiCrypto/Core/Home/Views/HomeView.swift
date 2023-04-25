//
//  HomeView.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio:Bool = false
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    CircleButtonView(iconName: "info")
                    Spacer()
                    Text("Live Prices")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(.theme.accent)
                    Spacer()
                    CircleButtonView(iconName: "chevron.right")
                        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                        .onTapGesture {
                            withAnimation(.spring()){
                                showPortfolio.toggle()
                            }
                            
                        }
                    
                }
                
                Text("Header")
                Spacer()
            }
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView()
                .toolbar(.hidden)
        }
        
    }
}

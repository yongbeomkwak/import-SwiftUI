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
                
                homeHeader

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

extension HomeView {
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none,value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent).animation(.none,value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                    
                }
            
        }
    }
    
}

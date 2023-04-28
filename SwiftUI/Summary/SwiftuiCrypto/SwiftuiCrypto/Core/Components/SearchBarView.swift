//
//  SearchBarView.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/04/28.
//

import SwiftUI

struct SearchBarView: View {
    
    @State var searchText:String = ""
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? .theme.secondaryText : .theme.accent)
            
            
            TextField("Search by name or symbol",text: $searchText)
                .foregroundColor(.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x:10)
                    .foregroundColor(.accentColor)
                    ,alignment: .trailing)
                    .opacity(searchText.isEmpty ? 0 : 1)
                    .onTapGesture {
                        searchText = ""
                    }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: .theme.accent.opacity(0.5), radius: 10,x: 0,y:0)
        )
        .padding()
    
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            SearchBarView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
            SearchBarView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
       
    }
}

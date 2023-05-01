//
//  SettingView.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct SettingView: View {
    
    let defaultURL = URL(string: "https://www.google.com")
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")
    
    var body: some View {
        NavigationStack{
            List{
                Section {
                    VStack(alignment: .leading){
                        Image("logo")
                            .resizable()
                            .frame(width: 100,height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            
                        Text("BlaBla")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.theme.accent)
                    }

                } header: {
                    Text("Swiftui Thinking")
                } footer: {
                    Text("Footer")
                }

                
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Setting")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                XMarkButton()
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingView()
        }
       
    }
}

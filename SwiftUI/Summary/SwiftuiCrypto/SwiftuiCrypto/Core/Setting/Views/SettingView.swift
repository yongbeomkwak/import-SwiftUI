//
//  SettingView.swift
//  SwiftuiCrypto
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationStack{
            List{
                
                Section {
                    Text("Hi")
                    Text("Hi")
                } header: {
                    Text("Header")
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

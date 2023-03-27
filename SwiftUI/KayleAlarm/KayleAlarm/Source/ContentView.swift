//
//  ContentView.swift
//  KayleAlarm
//
//  Created by yongbeomkwak on 2023/03/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                
                
        }
        .onAppear{
            for family in UIFont.familyNames {
                print(family)

                for names in UIFont.fontNames(forFamilyName: family) {

                    print("== \(names)")

                }
            }
        }
        .padding()
    }
            
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

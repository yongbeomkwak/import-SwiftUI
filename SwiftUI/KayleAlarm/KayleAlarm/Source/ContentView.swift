//
//  ContentView.swift
//  KayleAlarm
//
//  Created by yongbeomkwak on 2023/03/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("Bed")
            Text("Hello, world!")
                .font(.sfRounded())
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

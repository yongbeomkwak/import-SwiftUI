//
//  TransitionView.swift
//  Swiftful Thinking
//
//  Created by ssomac on 2023/05/02.
//

import SwiftUI

struct TransitionView: View {
    
    @State private var Showview: Bool = false
    
    var body: some View {

            ZStack(alignment: .bottom) {
                VStack {
                    Button("Button") {
                        self.Showview.toggle()
                    }
                    Spacer()
                }
                
                
                if Showview {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: UIScreen.main.bounds.height/2)
                        .transition(AnyTransition.slide)
                      .animation(Animation.easeInOut, value: Showview)
                }
                
            }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TransitionView_Previews: PreviewProvider {
    static var previews: some View {
        TransitionView()
    }
}

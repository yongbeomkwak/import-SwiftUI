//
//  NoItemsView.swift
//  TodoList
//
//  Created by yongbeomkwak on 2023/04/24.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing:10) {
                Text("There are no Items")
                    .font(.title)
                    .fontWeight(.semibold)
                    .on
                Text("Are you blababalbblablalablalbalblabl?balbalbalblabalblaadasdfsdaf")
                    .padding(.bottom,20)
                NavigationLink(destination: AddView(), label: {
                    Text("Add Something..")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background( animate ? .red : .blue)
                        .cornerRadius(10)
                })
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(color: animate ? .red.opacity(0.7) : .blue.opacity(0.7), radius: animate ? 30 : 10,x: 0,y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
                
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity )
    }
    
    func addAnimation() {
        
        guard !animate else {return}
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
            withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                animate.toggle()
            }
        })
    }
    
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
        }
        
    }
}

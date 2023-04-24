//
//  AddView.swift
//  TodoList
//
//  Created by yongbeomkwak on 2023/04/23.
//

import SwiftUI

struct AddView: View {
    
    @State var text:String = ""
    @EnvironmentObject var listViewModel:ListViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        
        ScrollView {
            
            VStack{
                TextField("Type Something", text: $text)
                .padding(.horizontal)
                .frame(height: 55)
                .background(.gray.opacity(0.5))
                .cornerRadius(15)
                
                Button {
                    saveButtonPressed()
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.primary)
                        .cornerRadius(10)
                }

            }
            .padding(14)
            
                
        }
        .navigationTitle("Add an Item ✏️")
        
    
    }
    
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: text)
            dismiss()
        }
        
        
    }
    
    func textIsAppropriate() -> Bool {
        if text.count < 3 {
            return false
        }
        
        return true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            AddView()
        }
        .environmentObject(ListViewModel())
        
    }
}

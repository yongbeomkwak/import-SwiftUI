//
//  AddView.swift
//  TodoList
//
//  Created by yongbeomkwak on 2023/04/23.
//

import SwiftUI

struct AddView: View {
    
    
    @EnvironmentObject var listViewModel:ListViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var text:String = ""
    @State var alertTitle:String = ""
    @State var showAlert:Bool = false
    
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
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        
    
    }
    
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: text)
            dismiss()
        }
        
        
    }
    
    func textIsAppropriate() -> Bool {
        if text.count < 3 {
            
            alertTitle = "최소글자를 어겼습니다. 3글자 이상"
            showAlert.toggle()
            
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

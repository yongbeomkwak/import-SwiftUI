//
//  Extension+View.swift
//  Alram
//
//  Created by yongbeomkwak on 2023/03/26.
//

import Foundation
import SwiftUI

extension View {
    
    var safeArea: UIEdgeInsets {
        
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
    
}
